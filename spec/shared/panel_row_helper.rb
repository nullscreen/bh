shared_examples_for 'the panel_row helper' do
  require 'bh/helpers/panel_row_helper'
  include Bh::PanelRowHelper

  all_tests_pass_with 'no panel_row block'
  all_tests_pass_with 'no panel_row options'
  all_tests_pass_with 'extra panel_row options'
  all_tests_pass_with 'the :column_class panel_row option'
end

#--

shared_examples_for 'no panel_row block' do
  specify 'displays an empty row' do
    expect(panel_row).to eq '<div class="row"></div>'
  end
end

shared_examples_for 'no panel_row options' do
  specify 'displays a row' do
    expect(nil).to generate_panel_row_with %r{^<div class="row">.*</div>$}m
  end
end

shared_examples_for 'extra panel_row options' do
  specify 'passes the options to the panel row <div>' do
    expect(class: :important, key: :value).to generate_panel_row_with %r{^<div class="important row" key="value">.*</div>$}m
  end
end

shared_examples_for 'the :column_class panel_row option' do
  specify 'wraps each panel in a grid div matching the specified columns' do
    expect(column_class: 'col-sm-4').to generate_panel_row_with %r{^<div class="row"><div class="col-sm-4">.*</div></div>$}m
  end
end

#--

RSpec::Matchers.define :generate_panel_row_with do |regex|
  require 'bh/helpers/panel_helper'
  include Bh::PanelHelper

  match do |options|
    block = panel_row(*[options].compact) { panel body: 'inline' }
    block.include?(%Q{inline}) && block.match(regex)
  end
end
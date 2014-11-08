shared_examples_for 'the vertical helper' do
  require 'bh/helpers/vertical_helper'
  include Bh::VerticalHelper

  all_tests_pass_with 'the vertical not wrapped in navbar'
  all_tests_pass_with 'no vertical options'
  all_tests_pass_with 'extra vertical options'
end

#--

shared_examples_for 'the vertical not wrapped in navbar' do
  specify 'returns nil' do
    expect(vertical).to be_nil
  end
end

shared_examples_for 'no vertical options' do
  specify 'creates a <div> element with the "navbar-header" class and toggle button' do
    html = %r{<div class="navbar-header"><button class="navbar-toggle" data-target="#.+?" data-toggle="collapse" type="button"><span class="sr-only">Toggle navigation</span>(\n<span class="icon-bar"></span>){3}</button>}m
    expect(nil).to generate_vertical_with html
  end
end

shared_examples_for 'extra vertical options' do
  let(:options) { {class: :important, id: 'my-navbar-header', data: {value: 1}} }
  specify 'passes the options to the <div> element' do
    html = %Q{<div class="important navbar-header" data-value="1" id="my-navbar-header"><button class="navbar-toggle"}
    expect(options).to generate_vertical_with html
  end
end

#--

RSpec::Matchers.define :generate_vertical_with do |regex|
  require 'bh/helpers/navbar_helper'
  include Bh::NavbarHelper

  match do |options|
    inline = navbar { vertical *['inline', options].compact }
    inline_match = inline.include?('inline') && inline.match(regex)

    block = navbar { vertical(*[options].compact) { 'block' } }
    block_match = block.include?('block') && block.match(regex)

    inline_match && block_match
  end
end
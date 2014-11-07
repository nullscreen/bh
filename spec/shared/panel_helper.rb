shared_examples_for 'the panel helper' do
  require 'bh/helpers/panel_helper'
  include Bh::PanelHelper

  all_tests_pass_with 'no panel options'
  all_tests_pass_with 'extra panel options'
  all_tests_pass_with 'the :heading panel option'
  all_tests_pass_with 'the :title panel option'
  all_tests_pass_with 'the :body panel option'
  all_tests_pass_with 'the :context panel option'
  all_tests_pass_with 'the :tag panel option'
end

#--

shared_examples_for 'no panel options' do
  specify 'displays a default panel' do
    expect(nil).to generate_panel_with %r{^<div class="panel panel-default">.*</div>$}m
  end
end

shared_examples_for 'extra panel options' do
  specify 'passes the options to the <div> panel' do
    expect(class: :important, key: :value).to generate_panel_with %r{^<div class="important panel panel-default" key="value">.*</div>$}m
  end
end

shared_examples_for 'the :heading panel option' do
  specify 'sets the heading of the panel to the specified value' do
    expect(heading: 'Heading').to generate_panel_with %r{<div class="panel-heading">Heading</div>}m
  end
end

shared_examples_for 'the :title panel option' do
  specify 'sets the title of the panel to the specified value' do
    expect(title: 'Title').to generate_panel_with %r{<div class="panel-heading"><h3 class="panel-title">Title</h3></div>}m
  end
end

shared_examples_for 'the :body panel option' do
  context 'given neither a content nor a block' do
    let(:html) { panel body: 'Body' }

    specify 'sets the body of the panel to the specified value' do
      expect(html).to include %Q{<div class="panel-body">Body</div>}
    end
  end

  context 'given a content' do
    let(:html) { panel 'content', body: 'Body' }

    specify 'ignores the :body option and uses the content' do
      expect(html).not_to include %Q{<div class="panel-body">Body</div>}
      expect(html).to include %Q{<div class="panel-body">content</div>}
    end
  end

  context 'given a block' do
    let(:html) { panel(body: 'Body') { 'block' } }

    specify 'ignores the :body option and uses the block' do
      expect(html).not_to include %Q{<div class="panel-body">Body</div>}
      expect(html).to include %Q{block}
    end
  end
end

shared_examples_for 'the :tag panel option' do
  specify 'uses the HTML tag instead of <div> to wrap the panel' do
    expect(tag: :aside).to generate_panel_with %r{^<aside class="panel panel-default">.*</aside>$}m
  end
end

shared_examples_for 'the :context panel option' do
  Bh::Panel.new.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      expect(context: context).to generate_panel_with %r{^<div class="panel #{context_class}">.*</div>$}m
    end
  end
end

#--

RSpec::Matchers.define :generate_panel_with do |regex|
  match do |options|
    inline = panel *['inline', options].compact
    inline_match = inline.include?(%Q{<div class="panel-body">inline</div>}) && inline.match(regex)

    block = panel(*[options].compact) { 'block' }
    block_match = block.include?('block') && block.match(regex)

    inline_match && block_match
  end
end



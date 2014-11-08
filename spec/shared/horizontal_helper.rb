shared_examples_for 'the horizontal helper' do
  require 'bh/helpers/horizontal_helper'
  include Bh::HorizontalHelper

  all_tests_pass_with 'the horizontal not wrapped in navbar'
  all_tests_pass_with 'no horizontal options'
  all_tests_pass_with 'extra horizontal options'
end

#--

shared_examples_for 'the horizontal not wrapped in navbar' do
  specify 'returns nil' do
    expect(horizontal).to be_nil
  end
end

shared_examples_for 'no horizontal options' do
  specify 'creates a <div> element with the "navbar-header" class and toggle button' do
    html = %r{<div class="collapse navbar-collapse" id=".+?">}
    expect(nil).to generate_horizontal_with html
  end
end

shared_examples_for 'extra horizontal options' do
  let(:options) { {class: :important, data: {value: 1}} }
  specify 'passes the options to the <div> element' do
    html = %r{<div class="important collapse navbar-collapse" data-value="1" id=".+?">}
    expect(options).to generate_horizontal_with html
  end
end

#--

RSpec::Matchers.define :generate_horizontal_with do |regex|
  require 'bh/helpers/navbar_helper'
  include Bh::NavbarHelper

  match do |options|
    inline = navbar { horizontal *['inline', options].compact }
    inline_match = inline.include?('inline') && inline.match(regex)

    block = navbar { horizontal(*[options].compact) { 'block' } }
    block_match = block.include?('block') && block.match(regex)

    inline_match && block_match
  end
end
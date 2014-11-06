shared_examples_for 'the button helper' do
  require 'bh/helpers/button_helper'
  include Bh::ButtonHelper

  all_tests_pass_with 'no button options'
  all_tests_pass_with 'extra button options'
  all_tests_pass_with 'the :context button option'
  all_tests_pass_with 'the :size button option'
  all_tests_pass_with 'the :layout button option'
end

#--

shared_examples_for 'no button options' do
  specify 'sets the class to "btn btn-default"' do
    expect(nil).to generate_button_with 'class="btn btn-default'
  end
end

shared_examples_for 'extra button options' do
  # specify 'passes the options to the wrapping <button>' do
  #   expect(class: 'text-left').to generate_button_with 'class="text-left'
  # end
end

shared_examples_for 'the :context button option' do
  Bh::Button.new.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      expect(context: context).to generate_button_with "#{context_class}"
    end
  end
end

shared_examples_for 'the :size button option' do
  Bh::Button.new.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      expect(size: size).to generate_button_with "#{size_class}"
    end
  end
end

shared_examples_for 'the :layout button option' do
  Bh::Button.new.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      expect(layout: layout).to generate_button_with "#{layout_class}"
    end
  end
end

#--

RSpec::Matchers.define :generate_button_with do |text|
  match do |options|
    inline = button *['inline', options].compact
    inline_match = inline.include?('inline') && inline.include?(text)

    block = button *[options].compact, &Proc.new{ 'block' }
    block_match = block.include?('block') && block.include?(text)

    inline_match && block_match
  end
end
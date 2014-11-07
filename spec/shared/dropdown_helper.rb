shared_examples_for 'the dropdown helper' do
  require 'bh/helpers/dropdown_helper'
  include Bh::DropdownHelper

  all_tests_pass_with 'no dropdown options'
  all_tests_pass_with 'the :context dropdown option'
  all_tests_pass_with 'the :size dropdown option'
  all_tests_pass_with 'the :layout dropdown option'
  all_tests_pass_with 'the :groupable dropdown option'
  all_tests_pass_with 'the :direction dropdown option'
  all_tests_pass_with 'the :align dropdown option'
  all_tests_pass_with 'the :split dropdown option'
end

#--

shared_examples_for 'no dropdown options' do
  specify 'uses the caption with a caret as the button caption' do
    button = %r{<button .+>.+Menu.+<span class="caret"></span>.+</button>}m
    expect(nil).to generate_dropdown_with button
  end
end

shared_examples_for 'the :context dropdown option' do
  Bh::Button.new.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      button = %r{<button class="dropdown-toggle.+?#{context_class}"}m
      expect(context: context).to generate_dropdown_with button
    end
  end
end

shared_examples_for 'the :size dropdown option' do
  Bh::Button.new.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      button = %r{<button class="dropdown-toggle.+?#{size_class}"}m
      expect(size: size).to generate_dropdown_with button
    end
  end
end

shared_examples_for 'the :layout dropdown option' do
  Bh::Button.new.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      button = %r{<button class="dropdown-toggle.+?#{layout_class}"}m
      expect(layout: layout).to generate_dropdown_with button
    end
  end
end

shared_examples_for 'the :groupable dropdown option' do
  Bh::Dropdown.new.groupables.each do |groupable, groupable_class|
    specify %Q{set to :#{groupable}, adds the class "#{groupable_class}"} do
      button = %r{<button class="dropdown-toggle.+?#{groupable_class}"}m
      expect(groupable: groupable).to generate_dropdown_with button
    end
  end
end

shared_examples_for 'the :direction dropdown option' do
  Bh::Dropdown.new.directions.each do |direction, direction_class|
    specify %Q{set to :#{direction}, adds the class "#{direction_class}"} do
      div = %r{<div class=".+?#{direction_class}"}m
      expect(direction: direction).to generate_dropdown_with div
    end
  end
end

shared_examples_for 'the :align dropdown option' do
  Bh::Dropdown.new.aligns.each do |align, align_class|
    specify %Q{set to :#{align}, adds the class "#{align_class}"} do
      button = %r{<button class="dropdown-toggle.+?#{align_class}"}m
      expect(align: align).to generate_dropdown_with button
    end
  end
end

shared_examples_for 'the :split dropdown option' do
  split = %r{</button>.+</button}m

  specify %Q{set to truthy, splits the caption and the caret} do
    expect(split: true).to generate_dropdown_with split
  end

  specify %Q{set to falsey, does not split the caption and the caret} do
    expect(split: false).not_to generate_dropdown_with split
  end

  specify %Q{not set, does not split the caption and the caret} do
    expect(nil).not_to generate_dropdown_with split
  end
end

#--

RSpec::Matchers.define :generate_dropdown_with do |regex|
  match do |options|
    block = dropdown(*['Menu', options].compact) { 'block' }

    block.include?('block') && block.match(regex)
  end
end
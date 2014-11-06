# encoding: UTF-8

shared_examples_for 'the alert_box helper' do
  require 'bh/helpers/alert_box_helper'
  include Bh::AlertBoxHelper

  all_tests_pass_with 'no alert options'
  all_tests_pass_with 'extra alert options'
  all_tests_pass_with 'the :context alert option'
  all_tests_pass_with 'the :dismissible alert option'
  all_tests_pass_with 'the :priority alert option'
end

#--

shared_examples_for 'no alert options' do
  specify 'sets the role and the class to "alert"' do
    expect(nil).to generate_alert_with 'role="alert"'
    expect(nil).to generate_alert_with 'class="alert alert-info"'
  end
end

shared_examples_for 'extra alert options' do
  specify 'passes the options to the wrapping <div>' do
    expect(class: 'text-left').to generate_alert_with 'class="text-left'
  end
end

shared_examples_for 'the :context alert option' do
  Bh::AlertBox.new.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      expect(context: context.to_s).to generate_alert_with context_class
    end
  end
end

shared_examples_for 'the :dismissible alert option' do
  specify 'set to true, displays an × to dismiss the alert' do
    expect(dismissible: true).to generate_alert_with '&times;'
  end

  specify 'set to false, does not display an ×' do
    expect(dismissible: false).not_to generate_alert_with '&times;'
  end

  specify 'not set, does not display an ×' do
    expect(nil).not_to generate_alert_with '&times;'
  end
end

shared_examples_for 'the :priority alert option' do
  specify 'set, displays an × to dismiss the alert' do
    expect(priority: :anything).to generate_alert_with '&times;'
  end

  specify 'set to :notice, adds the class "alert-success"' do
    expect(priority: :notice).to generate_alert_with 'alert alert-success'
  end

  specify 'set to :alert, adds the class "alert-danger"' do
    expect(priority: :alert).to generate_alert_with 'alert alert-danger'
  end
end


#--

RSpec::Matchers.define :generate_alert_with do |text|
  match do |options|
    inline = alert_box *['inline', options].compact
    inline_match = inline.include?('inline') && inline.include?(text.to_s)

    block = alert_box(*[options].compact) { 'block' }
    block_match = block.include?('block') && block.include?(text.to_s)

    inline_match && block_match
  end
end
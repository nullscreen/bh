require 'spec_helper'

describe 'When used in Middleman' do
  let(:bh) { MiddlemanMockViewWithBh.new }

  all_tests_pass_for 'the alert_box helper'
  all_tests_pass_for 'the button helper'
end
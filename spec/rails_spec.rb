require 'spec_helper'
require 'action_view'

describe 'When used in Rails' do
  include ActionView::Context # for capture

  all_tests_pass_for 'the alert_box helper'
end
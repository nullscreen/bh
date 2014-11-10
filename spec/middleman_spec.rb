require 'spec_helper'

describe 'When used in Middleman' do
  let(:bh) { MiddlemanView.new }

  all_tests_pass_for 'the alert_box helper'
  all_tests_pass_for 'the button helper'
  all_tests_pass_for 'the dropdown helper'
  all_tests_pass_for 'the glyphicon helper'
  all_tests_pass_for 'the icon helper'
  all_tests_pass_for 'the progress_bar helper'
  all_tests_pass_for 'the modal helper'
end
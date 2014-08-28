# encoding: UTF-8

require 'spec_helper'

require 'bh/helpers/alert_helper'
require 'bh/helpers/link_to_helper'
include Bh::AlertHelper
include Bh::LinkToHelper

describe 'alert_box' do
  describe 'accepts as parameters:' do
    let(:behave) { be_a String }

    specify 'a string (message)' do
      expect(alert_box 'message').to behave
    end

    specify 'a block (message)' do
      expect(alert_box { 'message' }).to behave
    end

    specify 'a string (message) + a hash (options)' do
      expect(alert_box 'message', context: :danger).to behave
    end

    specify 'a hash (options) + a block (message)' do
      expect(alert_box(context: :danger) { 'message' }).to behave
    end
  end

  describe 'with the :dismissible option' do
    specify 'not set, does not show an × to dismiss the alert' do
      expect(alert_box 'message').not_to include '&times;'
    end

    specify 'set to false, does not show an × to dismiss the alert' do
      expect(alert_box 'message', dismissible: false).not_to include '&times;'
    end

    specify 'set to true, does not show an × to dismiss the alert' do
      expect(alert_box 'message', dismissible: true).to include '&times;'
    end
  end

  describe 'with the :context option' do
    specify 'set to :success, shows a "success" alert' do
      expect(alert_box 'message', context: :success).to include 'alert-success'
    end

    specify 'set to :info, shows a "info" alert' do
      expect(alert_box 'message', context: :info).to include 'alert-info'
    end

    specify 'set to :warning, shows a "warning" alert' do
      expect(alert_box 'message', context: :warning).to include 'alert-warning'
    end

    specify 'set to :danger, shows a "danger" alert' do
      expect(alert_box 'message', context: :danger).to include 'alert-danger'
    end

    specify 'set to any other value, shows an "info" alert' do
      expect(alert_box 'message', context: :unknown).to include 'alert-info'
    end

    specify 'not set, shows an "info" alert' do
      expect(alert_box 'message').to include 'alert-info'
    end
  end

  describe 'with the :priority option' do
    specify 'shows a dismissible alert' do
      expect(alert_box 'message', priority: :notice).to include '&times;'
    end

    specify 'set to :notice, shows a "success" alert' do
      expect(alert_box 'message', priority: :notice).to include 'alert-success'
    end

    specify 'set to :alert, shows a "danger" alert' do
      expect(alert_box 'message', priority: :alert).to include 'alert-danger'
    end
  end
end
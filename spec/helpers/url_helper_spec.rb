require 'spec_helper'
require 'bh/helpers/alert_helper'
require 'bh/helpers/url_helper'
include Bh::AlertHelper
include Bh::UrlHelper

describe 'link_to' do
  context 'used without a block' do
    let(:link) { link_to 'Home', '/' }

    specify 'does not apply the "alert_link" class if used outside of an alert' do
      expect(link).not_to include 'alert-link'
    end

    specify 'applies the "alert_link" class if used inside an alert' do
      expect(alert_box { link }).to include 'alert-link'
    end
  end

  context 'used with a block' do
    let(:link) { link_to('/') { 'Home' } }

    specify 'does not apply the "alert_link" class if used outside of an alert' do
      expect(link).not_to include 'alert-link'
    end

    specify 'applies the "alert_link" class if used inside an alert' do
      expect(alert_box { link }).to include 'alert-link'
    end
  end
end
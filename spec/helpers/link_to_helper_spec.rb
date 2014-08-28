require 'spec_helper'
require 'action_dispatch'

require 'bh/helpers/alert_helper'
require 'bh/helpers/link_to_helper'
require 'bh/helpers/nav_helper'
require 'bh/helpers/navbar_helper'

include Bh::AlertHelper
include Bh::LinkToHelper
include Bh::NavHelper
include Bh::NavbarHelper

describe 'link_to' do
  let(:request) { ActionDispatch::Request.new request_options }
  let(:request_options) { {'REQUEST_METHOD' => 'GET'} }
  let(:url) { '/' }

  context 'used without a block' do
    let(:link) { link_to 'Home', url }

    specify 'by default, does not apply the "alert-link" class' do
      expect(link).not_to include 'alert-link'
    end

    specify 'inside an alert, applies the "alert-link"' do
      expect(alert_box { link }).to include 'alert-link'
    end

    specify 'by default, does not apply the "navbar-brand" class' do
      expect(link).not_to include 'navbar-brand'
    end

    specify 'inside the vertical part of a navbar, applies the "navbar-brand"' do
      expect(navbar { vertical { link } }).to include 'navbar-brand'
    end

    specify 'by default, does not surround the link in a list item' do
      expect(link).not_to include '<li>'
    end

    context 'inside a nav' do
      let(:html) { nav { link } }

      specify 'surrounds the link in a list item' do
        expect(html).to include '<li><a href="/">Home</a></li>'
      end

      specify 'by default, does not apply the "active" class' do
        expect(link).not_to include 'active'
      end

      context 'given the link points to the current page, applies the "active" class' do
        let(:url) { '' }
        it { expect(html).to include 'li class="active"' }
      end
    end
  end

  context 'used with a block' do
    let(:link) { link_to(url) { 'Home' } }

    specify 'by default, does not apply the "alert-link" class' do
      expect(link).not_to include 'alert-link'
    end

    specify 'inside an alert, applies the "alert-link"' do
      expect(alert_box { link }).to include 'alert-link'
    end

    specify 'by default, does not apply the "navbar-brand" class' do
      expect(link).not_to include 'navbar-brand'
    end

    specify 'inside the vertical part of a navbar, applies the "navbar-brand"' do
      expect(navbar { vertical { link } }).to include 'navbar-brand'
    end

    specify 'by default, does not surround the link in a list item' do
      expect(link).not_to include '<li>'
    end

    context 'inside a nav' do
      let(:html) { nav { link } }

      specify 'surrounds the link in a list item' do
        expect(html).to include '<li><a href="/">Home</a></li>'
      end

      specify 'by default, does not apply the "active" class' do
        expect(link).not_to include 'active'
      end

      context 'given the link points to the current page, applies the "active" class' do
        let(:url) { '' }
        it { expect(html).to include 'li class="active"' }
      end
    end
  end
end
# encoding: UTF-8

require 'spec_helper'
require 'bh/helpers/nav_helper'
require 'bh/helpers/navbar_helper'

include Bh::NavHelper
include Bh::NavbarHelper

describe 'nav' do
  let(:html) { nav options, &block }
  let(:block) { Proc.new {} }
  let(:options) { {} }

  describe 'with the :as option' do
    specify 'not set, shows a "tabs" nav' do
      expect(html).to include 'ul class="nav nav-tabs" role="tablist"'
    end

    context 'set to :tabs, shows a "tabs" nav' do
      let(:options) { {as: :tabs} }
      it { expect(html).to include 'ul class="nav nav-tabs"' }
    end

    context 'set to :pills, shows a "tabs" nav' do
      let(:options) { {as: :pills} }
      it { expect(html).to include 'ul class="nav nav-pills"' }
    end
  end

  describe 'with the :layout option' do
    specify 'not set, does not set a layout' do
      expect(html).to include 'ul class="nav nav-tabs" role="tablist"'
    end

    context 'set to :justified, shows a "justified" nav' do
      let(:options) { {layout: :justified} }
      it { expect(html).to include 'nav-justified' }
    end

    context 'set to :stacked, shows a "stacked" nav' do
      let(:options) { {layout: :stacked} }
      it { expect(html).to include 'nav-stacked' }
    end
  end

  describe 'within a navbar' do
    let(:html) { navbar { nav options, &block } }
    specify 'applies roles and classes specific to navbar' do
      expect(html).to include 'ul class="nav navbar-nav">'
    end
  end
end
# encoding: UTF-8

require 'spec_helper'
require 'bh/helpers/panel_helper'
include Bh::PanelHelper

describe 'panel' do
  describe 'accepts as parameters:' do
    let(:behave) { include 'content' }

    specify 'a string (content)' do
      expect(panel 'content').to behave
    end

    specify 'a hash (options)' do
      expect(panel body: 'content').to behave
    end

    specify 'a block (content)' do
      expect(panel { 'content' }).to behave
    end

    specify 'a string (content) + a hash (options)' do
      expect(panel 'content', context: :danger).to behave
    end

    specify 'a hash (options) + a block (content)' do
      expect(panel(context: :danger) { 'content' }).to behave
    end
  end

  describe 'with the :context option' do
    specify 'set to :default, shows a "default" panel' do
      expect(panel 'content', context: :default).to include 'panel-default'
    end

    specify 'set to :primary, shows a "primary" panel' do
      expect(panel 'content', context: :primary).to include 'panel-primary'
    end

    specify 'set to :success, shows a "success" panel' do
      expect(panel 'content', context: :success).to include 'panel-success'
    end

    specify 'set to :info, shows a "info" panel' do
      expect(panel 'content', context: :info).to include 'panel-info'
    end

    specify 'set to :warning, shows a "warning" panel' do
      expect(panel 'content', context: :warning).to include 'panel-warning'
    end

    specify 'set to :danger, shows a "danger" panel' do
      expect(panel 'content', context: :danger).to include 'panel-danger'
    end

    specify 'set to any other value, shows an "default" panel' do
      expect(panel 'content', context: :unknown).to include 'panel-default'
    end

    specify 'not set, shows an "default" panel' do
      expect(panel 'content').to include 'panel-default'
    end
  end

  describe 'with the :body option' do
    specify 'includes its value in the panel body' do
      expect(panel 'content', body: 'Your profile was updated', title: 'Profile').to include '<div class="panel-body">Your profile was updated</div>'
    end
  end

  describe 'with the :heading option' do
    specify 'includes its value in the panel heading' do
      expect(panel 'content', heading: 'Profile').to include '<div class="panel-heading">Profile</div>'
    end
  end

  describe 'with the :title option' do
    specify 'includes its value as a title in the panel heading' do
      expect(panel 'content', title: 'Profile').to include '<div class="panel-heading"><h3 class="panel-title">Profile</h3></div>'
    end
  end

  describe 'without the :heading or the :title option' do
    specify 'does not include the panel heading' do
      expect(panel 'content').not_to include 'panel-heading'
    end
  end

  describe 'with the :tag option' do
    specify 'uses the specified tag rather than DIV' do
      expect(panel 'content', tag: :aside).to include '<aside class="panel panel-default">'
    end
  end
end
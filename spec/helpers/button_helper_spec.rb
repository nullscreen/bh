# encoding: UTF-8

require 'spec_helper'
require 'bh/helpers/button_helper'
include Bh::ButtonHelper

describe 'button' do
  describe 'accepts as parameters:' do
    let(:behave) { match %r{^<button class="btn.+?">content</button>} }

    specify 'a string (content)' do
      expect(button 'content').to behave
    end

    specify 'a block (content)' do
      expect(button { 'content' }).to behave
    end

    specify 'a string (content) + a hash (options)' do
      expect(button 'content', context: :danger).to behave
    end

    specify 'a hash (options) + a block (content)' do
      expect(button(context: :danger) { 'content' }).to behave
    end
  end

  describe 'with the :context option' do
    let(:html) { button 'content', context: context }

    describe 'set to :primary, shows a "primary" button' do
      let(:context) { :primary }
      it { expect(html).to include 'btn-primary' }
    end

    describe 'set to :success, shows a "success" button' do
      let(:context) { :success }
      it { expect(html).to include 'btn-success' }
    end

    describe 'set to :info, shows a "info" button' do
      let(:context) { :info }
      it { expect(html).to include 'btn-info' }
    end

    describe 'set to :warning, shows a "warning" button' do
      let(:context) { :warning }
      it { expect(html).to include 'btn-warning' }
    end

    describe 'set to :danger, shows a "danger" button' do
      let(:context) { :danger }
      it { expect(html).to include 'btn-danger' }
    end

    describe 'set to :link, shows a "link" button' do
      let(:context) { :link }
      it { expect(html).to include 'btn-link' }
    end

    describe 'set to any other value, shows a "default" button' do
      let(:context) { :unknown }
      it { expect(html).to include 'btn-default' }
    end
  end

  describe 'without the :context option, shows a "default" button' do
    let(:html) { button 'content' }
    it { expect(html).to include 'btn-default' }
  end

  describe 'with the :size option' do
    let(:html) { button 'content', size: size }

    describe 'set to :large, shows a large button' do
      let(:size) { :large }
      it { expect(html).to include 'btn-lg' }
    end

    describe 'set to :small, shows a small button' do
      let(:size) { :small }
      it { expect(html).to include 'btn-sm' }
    end

    describe 'set to :extra_small, shows an extra-small button' do
      let(:size) { :extra_small }
      it { expect(html).to include 'btn-xs' }
    end
  end


  describe 'with the :layout option' do
    let(:html) { button 'content', layout: layout }

    describe 'set to :block, shows a "block" button' do
      let(:layout) { :block }
      it { expect(html).to include 'btn-block' }
    end
  end
end
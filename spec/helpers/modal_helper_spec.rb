# encoding: UTF-8

require 'spec_helper'
require 'action_dispatch'
require 'bh/helpers/modal_helper'
include Bh::ModalHelper

describe 'modal' do
  let(:views_folder) { File.expand_path('../../../lib/bh/views', __FILE__) }
  let(:lookup_context) { ActionView::LookupContext.new views_folder }
  let(:view_renderer) { ActionView::Renderer.new lookup_context }
  describe 'accepts as parameters:' do
    let(:behave) { include 'content' }

    specify 'a string (content)' do
      expect(modal 'content').to behave
    end

    specify 'a hash (options)' do
      expect(modal body: 'content').to behave
    end

    specify 'a block (content)' do
      expect(modal { 'content' }).to behave
    end

    specify 'a string (content) + a hash (options)' do
      expect(modal 'content', context: :danger).to behave
    end

    specify 'a hash (options) + a block (content)' do
      expect(modal(context: :danger) { 'content' }).to behave
    end
  end

  describe 'with the :button option' do
    let(:html) { modal 'content', button: button_options }

    describe 'with the :context option' do
      let(:button_options) { {context: context} }

      describe 'set to :primary, shows a "primary" toggle button' do
        let(:context) { :primary }
        it { expect(html).to include 'btn-primary' }
      end

      describe 'set to :success, shows a "success" toggle button' do
        let(:context) { :success }
        it { expect(html).to include 'btn-success' }
      end

      describe 'set to :info, shows a "info" toggle button' do
        let(:context) { :info }
        it { expect(html).to include 'btn-info' }
      end

      describe 'set to :warning, shows a "warning" toggle button' do
        let(:context) { :warning }
        it { expect(html).to include 'btn-warning' }
      end

      describe 'set to :danger, shows a "danger" toggle button' do
        let(:context) { :danger }
        it { expect(html).to include 'btn-danger' }
      end

      describe 'set to :link, shows a "link" toggle button' do
        let(:context) { :link }
        it { expect(html).to include 'btn-link' }
      end

      describe 'set to any other value, shows a "default" toggle button' do
        let(:context) { :unknown }
        it { expect(html).to include 'btn-default' }
      end
    end

    describe 'without the :context option, shows a "default" toggle button' do
      let(:button_options) { {} }
      it { expect(html).to include 'btn-default' }
    end

    describe 'with the :size option' do
      let(:button_options) { {size: size} }

      describe 'set to :large, shows a large toggle button' do
        let(:size) { :large }
        it { expect(html).to include 'btn-lg' }
      end

      describe 'set to :small, shows a small toggle button' do
        let(:size) { :small }
        it { expect(html).to include 'btn-sm' }
      end

      describe 'set to :extra_small, shows an extra-small toggle button' do
        let(:size) { :extra_small }
        it { expect(html).to include 'btn-xs' }
      end
    end

    describe 'with the :caption option, shows the caption on the button' do
      let(:button_options) { {caption: 'Call to action'} }
      it { expect(html).to include 'Call to action' }
    end
  end

  describe 'with the :size option' do
    let(:html) { modal 'content', size: size }

    describe 'set to :large, shows a large modal' do
      let(:size) { :large }
      it { expect(html).to include 'modal-dialog modal-lg' }
    end

    describe 'set to :small, shows a small modal' do
      let(:size) { :small }
      it { expect(html).to include 'modal-dialog modal-sm' }
    end
  end

  describe 'with the :body option' do
    specify 'includes its value in the modal body' do
      expect(modal body: 'Your profile was updated', title: 'Profile').to include '<div class="modal-body">Your profile was updated</div>'
    end
  end

  describe 'with the :title option' do
    specify 'includes its value as a title in the modal heading' do
      expect(modal 'content', title: 'Profile').to include 'Profile</h4>'
    end
  end
end
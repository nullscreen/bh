# encoding: UTF-8

require 'spec_helper'
require 'action_dispatch'
require 'bh/helpers/dropdown_helper'
include Bh::DropdownHelper

describe 'dropdown' do
  attr_accessor :output_buffer
  let(:caption) { 'Menu' }
  let(:options) { {} }
  let(:html) { dropdown(caption, options) {} }

  specify 'uses the caption with a caret as the button caption' do
    expect(html).to match %r{<button .+>.+Menu.+<span class="caret"></span>.+</button>}m
  end

  describe 'with the :groupable option' do
    specify 'not set, wraps the dropdown in a "btn-group" div' do
      expect(html).to include '<div class="btn-group">'
    end

    describe 'set to true, wraps the dropdown in a "btn-group" div' do
      let(:options) { {groupable: true} }
      it { expect(html).to include '<div class="btn-group">' }
    end

    describe 'set to false, wraps the dropdown in a "dropdown" div' do
      let(:options) { {groupable: false} }
      it { expect(html).to include '<div class="dropdown">' }
    end
  end

  describe 'with the :align option' do
    specify 'not set, wraps the list in a "dropdown-menu" ul' do
      expect(html).to include '<ul class="dropdown-menu"'
    end

    describe 'set to :left, wraps the dropdown in a dropdown-menu" ul' do
      let(:options) { {align: :left} }
      it { expect(html).to include '<ul class="dropdown-menu"' }
    end

    describe 'set to :right, adds the dropdown-menu-right class to the ul' do
      let(:options) { {align: :right} }
      it { expect(html).to include '<ul class="dropdown-menu dropdown-menu-right"' }
    end
  end

  describe 'with the :direction option' do
    specify 'not set, uses the default dropdown direction' do
      expect(html).not_to include 'dropup'
    end

    describe 'set to :down, uses the default dropdown direction' do
      let(:options) { {direction: :down} }
      it { expect(html).not_to include 'dropup' }
    end

    describe 'set to :up, adds the dropup class to the div' do
      let(:options) { {direction: :up} }
      it { expect(html).to include 'dropup' }
    end
  end

  describe 'with the :split option' do
    specify 'not set, uses a single dropdown button' do
      expect(html).not_to match %r{</button>.+</button}m
    end

    describe 'set to false, uses a single dropdown button' do
      let(:options) { {split: false} }
      it { expect(html).not_to match %r{</button>.+</button}m }
    end

    describe 'set to true, uses a split dropdown button' do
      let(:options) { {split: true} }
      it { expect(html).to match %r{</button>.+</button}m }
    end
  end

  describe 'with the :context option' do
    let(:options) { {context: context} }

    describe 'set to :primary, shows a "primary" dropdown button' do
      let(:context) { :primary }
      it { expect(html).to include 'btn-primary' }
    end

    describe 'set to :success, shows a "success" dropdown button' do
      let(:context) { :success }
      it { expect(html).to include 'btn-success' }
    end

    describe 'set to :info, shows a "info" dropdown button' do
      let(:context) { :info }
      it { expect(html).to include 'btn-info' }
    end

    describe 'set to :warning, shows a "warning" dropdown button' do
      let(:context) { :warning }
      it { expect(html).to include 'btn-warning' }
    end

    describe 'set to :danger, shows a "danger" dropdown button' do
      let(:context) { :danger }
      it { expect(html).to include 'btn-danger' }
    end

    describe 'set to :link, shows a "link" dropdown button' do
      let(:context) { :link }
      it { expect(html).to include 'btn-link' }
    end

    describe 'set to any other value, shows a "default" dropdown button' do
      let(:context) { :unknown }
      it { expect(html).to include 'btn-default' }
    end
  end

  describe 'without the :context option, shows a "default" dropdown button' do
    let(:options) { {} }
    it { expect(html).to include 'btn-default' }
  end

  describe 'with the :size option' do
    let(:options) { {size: size} }

    describe 'set to :large, shows a large dropdown button' do
      let(:size) { :large }
      it { expect(html).to include 'btn-lg' }
    end

    describe 'set to :small, shows a small dropdown button' do
      let(:size) { :small }
      it { expect(html).to include 'btn-sm' }
    end

    describe 'set to :extra_small, shows an extra-small dropdown button' do
      let(:size) { :extra_small }
      it { expect(html).to include 'btn-xs' }
    end
  end
end
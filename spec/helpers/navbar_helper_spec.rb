# encoding: UTF-8

require 'spec_helper'
require 'bh/helpers/navbar_helper'
require 'bh/helpers/nav_helper'

include Bh::NavbarHelper
include Bh::NavHelper

describe 'navbar' do
  attr_accessor :output_buffer
  let(:html) { navbar options, &block }
  let(:block) { Proc.new {} }
  let(:options) { {} }

  specify 'applies Bootstrap attributes to the navbar' do
    expect(html).to match %r{<nav.+? role="navigation">}
  end

  describe 'with the :fluid option' do
    specify 'not set, adds a "container" div to the navbar' do
      expect(html).to include '<div class="container">'
    end

    context 'set to false, adds a "container" div to the navbar' do
      let(:options) { {fluid: false} }
      it { expect(html).to include '<div class="container">' }
    end

    context 'set to true, adds a "container-fluid" div to the navbar' do
      let(:options) { {fluid: true} }
      it { expect(html).to include '<div class="container-fluid">' }
    end
  end

  describe 'with the :inverted option' do
    specify 'not set, shows a "default" navbar' do
      expect(html).to include 'nav class="navbar navbar-default"'
    end

    context 'set to false, shows a "default" nav' do
      let(:options) { {inverted: false} }
      it { expect(html).to include 'nav class="navbar navbar-default"' }
    end

    context 'set to true, shows an "inverse" nav' do
      let(:options) { {inverted: true} }
      it { expect(html).to include 'nav class="navbar navbar-inverse"' }
    end
  end

  describe 'with the :position option' do
    specify 'not set, does not set a navbar position' do
      expect(html).to include 'nav class="navbar navbar-default"'
    end

    context 'set to :static, shows the navbar at the top (static) without padding' do
      let(:options) { {position: :static} }
      it { expect(html).to include 'nav class="navbar navbar-default navbar-static-top"' }
      it { expect(html).not_to include 'padding' }
    end

    context 'set to :static_top, shows the navbar at the top (static) without padding' do
      let(:options) { {position: :static_top} }
      it { expect(html).to include 'nav class="navbar navbar-default navbar-static-top"' }
      it { expect(html).not_to include 'padding' }
    end

    context 'set to :top, shows the navbar at the top (fixed)' do
      let(:options) { {position: :top} }
      it { expect(html).to include 'nav class="navbar navbar-default navbar-fixed-top"' }

      context 'with the :padding' do
        specify 'not set, adds 70px to the top padding of the body' do
          expect(html).to include '<style>body {padding-top: 70px}</style>'
        end

        context 'set to a value, adds those pixels to the top padding of the body' do
          let(:options) { {position: :top, padding: 100} }

          it { expect(html).to include '<style>body {padding-top: 100px}</style>' }
        end

        context 'set to nil, does not add a top padding to the body' do
          let(:options) { {position: :top, padding: nil} }

          it { expect(html).not_to include 'padding' }
        end
      end
    end

    context 'set to :fixed_top, shows the navbar at the top (fixed)' do
      let(:options) { {position: :fixed_top} }
      it { expect(html).to include 'nav class="navbar navbar-default navbar-fixed-top"' }
    end

    context 'set to :bottom, shows the navbar at the bottom (fixed)' do
      let(:options) { {position: :bottom} }
      it { expect(html).to include 'nav class="navbar navbar-default navbar-fixed-bottom"' }

      context 'with the :padding' do
        specify 'not set, adds 70px to the bottom padding of the body' do
          expect(html).to include '<style>body {padding-bottom: 70px}</style>'
        end

        context 'set to a value, adds those pixels to the bottom padding of the body' do
          let(:options) { {position: :bottom, padding: 100} }

          it { expect(html).to include '<style>body {padding-bottom: 100px}</style>' }
        end

        context 'set to nil, does not add a bottom padding to the body' do
          let(:options) { {position: :bottom, padding: nil} }

          it { expect(html).not_to include 'padding' }
        end
      end
    end

    context 'set to :fixed_bottom, shows the navbar at the bottom (fixed)' do
      let(:options) { {position: :fixed_bottom} }
      it { expect(html).to include 'nav class="navbar navbar-default navbar-fixed-bottom"' }
    end
  end
end

describe 'multiple navbars' do
  let(:navbar_1) { navbar inverted: true do
    safe_join [vertical(link_to 'Home', '/'), horizontal(content_tag :p, '')]
  end }
  let(:navbar_2) { navbar position: :top do
    safe_join [vertical(content_tag :p, ''), horizontal(link_to 'Home', '/')]
  end }
  let(:html) { safe_join [navbar_1, navbar_2], "\n"}

  specify 'toggle their own horizontal part when clicking on vertical' do
    navbar_ids = html.scan %r{<nav.+?data-target="#(.+?)".+?id="(\1)".+?</nav>}m

    expect(navbar_ids.size).to eq 2
    expect(navbar_ids.uniq.size).to eq 2
  end
end

describe 'with the :id navbar option' do
  let(:id) { 'my-navbar' }
  let(:html) { navbar(id: id) {safe_join [vertical, horizontal]} }
  it 'uses the id for the vertical and horizontal elements' do
    expect(html).to include %Q{button class="navbar-toggle" data-target="##{id}"}
    expect(html).to include %Q{div class="collapse navbar-collapse" id="#{id}"}
  end
end

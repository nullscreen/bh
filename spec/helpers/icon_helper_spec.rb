require 'spec_helper'
require 'bh/helpers/icon_helper'
include Bh::IconHelper

describe 'icon' do
  context 'given the icon name' do
    specify 'has underscores, returns the icon with dashes' do
      expect(icon :zoom_in).to eq '<span class="glyphicon glyphicon-zoom-in"></span>'
    end

    specify 'has dashes, returns the icon with dashes' do
      expect(icon 'zoom-out').to eq '<span class="glyphicon glyphicon-zoom-out"></span>'
    end

    specify 'is missing, returns an empty icon' do
      expect(icon).to eq '<span class="glyphicon"></span>'
    end
  end

  context 'given the :library option (underscored)' do
    specify 'is glyphicon, shows a Glyphicons icon' do
      expect(icon :heart, library: :glyphicon).to eq '<span class="glyphicon glyphicon-heart"></span>'
    end

    specify 'is font-awesome, shows a Font Awesome icon' do
      expect(icon :heart, library: 'font-awesome').to eq '<span class="fa fa-heart"></span>'
    end

    specify 'is font_awesome, shows a Font Awesome icon' do
      expect(icon :heart, library: :font_awesome).to eq '<span class="fa fa-heart"></span>'
    end

    specify 'is any other string, uses the string as a prefix' do
      expect(icon :heart, library: :custom).to eq '<span class="custom custom-heart"></span>'
    end

    specify 'is missing, shows a Glyphicons icon' do
      expect(icon :heart).to eq '<span class="glyphicon glyphicon-heart"></span>'
    end
  end

  specify 'given extra options, passes the options to the <span>' do
    expect(icon :ok, title: 'Approved').to eq '<span class="glyphicon glyphicon-ok" title="Approved"></span>'
  end
end
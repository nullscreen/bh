require 'spec_helper'
require 'bh/helpers/icon_helper'
include Bh::IconHelper

describe 'glyphicon' do
  specify 'given an icon name with underscores, returns the icon' do
    expect(icon :zoom_in).to eq '<span class="glyphicon glyphicon-zoom-in"></span>'
  end

  specify 'given an icon name with dashes, returns the icon' do
    expect(icon 'zoom-out').to eq '<span class="glyphicon glyphicon-zoom-out"></span>'
  end

  specify 'given no icon name, returns an empty icon' do
    expect(icon).to eq '<span class="glyphicon"></span>'
  end

  specify 'given extra options, passes the options to the <span>' do
    expect(icon :ok, title: 'Approved').to eq '<span class="glyphicon glyphicon-ok" title="Approved"></span>'
  end
end

describe 'font_awesome' do
  specify 'given an icon name with underscores, returns the icon' do
    expect(icon :fire, library: :font_awesome).to eq '<span class="fa fa-fire"></span>'
  end

  specify 'given an icon name with dashes, returns the icon' do
    expect(icon 'fire_extinguisher', library: :font_awesome).to eq '<span class="fa fa-fire-extinguisher"></span>'
  end

  specify 'given nil as icon name, returns an empty icon' do
    expect(icon nil, library: :font_awesome).to eq '<span class="fa"></span>'
  end

  specify 'given extra options, passes the options to the <span>' do
    expect(icon :ok, library: :font_awesome, title: 'Approved').to eq '<span class="fa fa-ok" title="Approved"></span>'
  end

  specify 'given size option, appends size class to the <span>' do
    expect(icon :ok, library: :font_awesome, size: 2).to eq '<span class="fa fa-ok fa-2x"></span>'
  end

  specify 'given fixed option, appends fixed width class to the <span>' do
    expect(icon :ok, library: :font_awesome, fixed: true).to eq '<span class="fa fa-ok fa-fw"></span>'
  end
end
require 'spec_helper'
require 'bh/helpers/font_awesome_helper'
include Bh::FontAwesomeHelper

describe 'font_awesome' do
  specify 'given an icon name with underscores, returns the icon' do
    expect(font_awesome :fire).to eq '<span class="fa fa-fire"></span>'
  end

  specify 'given an icon name with dashes, returns the icon' do
    expect(font_awesome 'fire_extinguisher').to eq '<span class="fa fa-fire-extinguisher"></span>'
  end

  specify 'given no icon name, returns an empty icon' do
    expect(font_awesome).to eq '<span class="fa"></span>'
  end

  specify 'given extra options, passes the options to the <span>' do
    expect(font_awesome :ok, title: 'Approved').to eq '<span class="fa fa-ok" title="Approved"></span>'
  end

  specify 'given size option, appends size class to the <span>' do
    expect(font_awesome :ok, size: 2).to eq '<span class="fa fa-ok fa-2x"></span>'
  end

  specify 'given fixed option, appends fixed width class to the <span>' do
    expect(font_awesome :ok, fixed: true).to eq '<span class="fa fa-ok fa-fw"></span>'
  end
end
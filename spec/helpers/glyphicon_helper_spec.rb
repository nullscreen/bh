require 'spec_helper'
require 'bh/helpers/glyphicon_helper'
include Bh::GlyphiconHelper

describe 'glyphicon' do
  specify 'given an icon name with underscores, returns the icon' do
    expect(glyphicon :zoom_in).to eq '<span class="glyphicon glyphicon-zoom-in"></span>'
  end

  specify 'given an icon name with dashes, returns the icon' do
    expect(glyphicon 'zoom-out').to eq '<span class="glyphicon glyphicon-zoom-out"></span>'
  end

  specify 'given no icon name, returns an empty icon' do
    expect(glyphicon).to eq '<span class="glyphicon"></span>'
  end

  specify 'given extra options, passes the options to the <span>' do
    expect(glyphicon :ok, title: 'Approved').to eq '<span class="glyphicon glyphicon-ok" title="Approved"></span>'
  end
end
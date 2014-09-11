require 'spec_helper'
require 'bh/helpers/font_awesome_helper'
include Bh::FontAwesomeHelper

describe 'font_awesome' do
  specify 'given an icon name with underscores, returns the icon' do
    expect(font_awesome :fire).to eq '<i class="fa fa-fire"></i>'
  end

  specify 'given an icon name with dashes, returns the icon' do
    expect(font_awesome 'fire_extinguisher').to eq '<i class="fa fa-fire-extinguisher"></i>'
  end

  specify 'given no icon name, returns an empty icon' do
    expect(font_awesome).to eq '<i class="fa"></i>'
  end

  specify 'given extra options, passes the options to the <i>' do
    expect(font_awesome :ok, title: 'Approved').to eq '<i class="fa fa-ok" title="Approved"></i>'
  end
end
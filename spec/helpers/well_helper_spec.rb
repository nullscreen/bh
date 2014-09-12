require 'spec_helper'
require 'bh/helpers/well_helper'
include Bh::WellHelper

describe 'well' do
  specify 'given a block it renders its default classes' do
    expect(well { 'well_content' }).to include 'class="well'
  end

  specify 'given a block it renders its contents' do
    expect(well { 'well_content' }).to include 'well_content'
  end

  specify 'given size option and a block it renders sizes classes' do
    expect(well(size: :large) { 'well_content' }).to include 'well-lg'
  end
end
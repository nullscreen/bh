require 'spec_helper'
require 'bh/helpers/badge_helper'
include Bh::BadgeHelper

describe 'label' do
  specify 'given a text it renders the default label' do
    expect(badge 'New', as: :label).to eq '<span class="label label-default">New</span>'
  end

  specify 'given a text and optons it renders the label with options' do
    expect(badge 'New', as: :label, context: :info).to eq '<span class="label label-info">New</span>'
  end
end

describe 'badge' do
  specify 'given no :as option it defaults to as: :badge' do
    expect(badge 'New').to eq '<span class="badge badge-default">New</span>'
  end

  specify 'given only nil it renders default badge with no content' do
    expect(badge nil).to eq '<span class="badge badge-default"></span>'
  end

  specify 'given a text it renders the default badge' do
    expect(badge 'New', as: :badge).to eq '<span class="badge badge-default">New</span>'
  end

  specify 'given a text and optons it renders the badge with options' do
    expect(badge 'New', as: :badge, context: :info).to eq '<span class="badge badge-info">New</span>'
  end

  specify 'given an unknown :as options it raises ArgumentError' do
    expect { badge nil, as: :non_existing_type }.to raise_error ArgumentError, 'Unknown option for as: non_existing_type'
  end

  specify 'given a Hash, as its only argument, raises ArgumentError' do
    expect { badge as: :non_existing_type }.to raise_error ArgumentError, 'content can *not* be a hash'
  end
end
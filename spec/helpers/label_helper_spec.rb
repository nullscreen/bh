# encoding: UTF-8

require 'spec_helper'

require 'bh/helpers/label_helper'
include Bh::LabelHelper

describe 'bh_label' do

  it 'returns a Bootstrap label' do
    expect(bh_label 'hello').to eq '<span class="label label-default">hello</span>'
  end

  context 'when specifying a valid :context' do
    specify ':primary context' do
      expect(bh_label 'hello', context: :primary).to eq '<span class="label label-primary">hello</span>'
    end

    specify ':success context' do
      expect(bh_label 'hello', context: :success).to eq '<span class="label label-success">hello</span>'
    end

    specify ':info context' do
      expect(bh_label 'hello', context: :info).to eq '<span class="label label-info">hello</span>'
    end

    specify ':warning context' do
      expect(bh_label 'hello', context: :warning).to eq '<span class="label label-warning">hello</span>'
    end

    specify ':danger context' do
      expect(bh_label 'hello', context: :danger).to eq '<span class="label label-danger">hello</span>'
    end
  end

  context 'when specifying an invalid :context' do
    it 'returns the default context' do
      expect(bh_label 'hello', context: :foobar).to eq '<span class="label label-default">hello</span>'
    end
  end

end
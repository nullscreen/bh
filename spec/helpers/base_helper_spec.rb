require 'spec_helper'
require 'bh/helpers/base_helper'
include Bh::BaseHelper

describe 'class_for_context' do
  specify 'given a prefix and context, returns bootstrap context class' do
    expect(class_for_context 'label', :info).to eq 'label label-info'
  end

  specify 'given a prefix and no context, returns default bootstrap context class' do
    expect(class_for_context 'label').to eq 'label label-default'
  end
end

describe 'class_for_size' do
  specify 'given a prefix and size, returns bootstrap size class' do
    expect(class_for_size 'label', :large).to       eq 'label-lg'
    expect(class_for_size 'label', :lg).to          eq 'label-lg'
    expect(class_for_size 'label', :small).to       eq 'label-sm'
    expect(class_for_size 'label', :sm).to          eq 'label-sm'
    expect(class_for_size 'label', :extra_small).to eq 'label-xs'
    expect(class_for_size 'label', :xs).to          eq 'label-xs'
  end

  specify 'given a prefix and no size, returns empty string' do
    expect(class_for_size 'label').to eq ''
  end
end
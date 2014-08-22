require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'legend' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for User.new, layout: layout, url: '/', &block }
  let(:block) { Proc.new {|f| f.legend 'Basic info' } }
  let(:layout) { :whatever }

  specify 'adds a <legend> to the form' do
    expect(form).to include 'legend'
  end

  describe 'given a basic layout' do
    let(:layout) { :basic }
    specify 'applies form-group to the container' do
      expect(form).to match %r{<div class="form-group"><legend>Basic info</legend></div>}
    end
  end

  describe 'given a horizontal layout' do
    let(:layout) { :horizontal }
    specify 'applies form-group to the container, col-sm-12 to the field container' do
      expect(form).to match %r{<div class="form-group"><div class="col-sm-12"><legend>Basic info</legend></div>}
    end
  end

  describe 'given an inline layout' do
    let(:layout) { :inline }
    specify 'applies sr-only to the legend' do
      expect(form).to match %r{<legend class="sr-only">Basic info</legend>}
    end
  end
end
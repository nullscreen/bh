require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'form_for' do
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  let(:form) { form_for(:object, options.merge(url: '/')) {} }

  describe 'without a :layout option' do
    let(:options) { {} }

    specify 'does not apply Bootstrap attributes to the form' do
      expect(form).not_to include 'role="form"'
    end
  end

  describe 'with layout: :horizontal' do
    let(:options) { {layout: :horizontal} }

    specify 'applies Bootstrap attributes of an horizontal form' do
      expect(form).to include 'role="form"'
      expect(form).to include 'class="form-horizontal"'
    end
  end

  describe 'with layout: :inline' do
    let(:options) { {layout: :inline} }

    specify 'applies Bootstrap attributes of an inline form' do
      expect(form).to include 'role="form"'
      expect(form).to include 'class="form-inline"'
    end
  end

  describe 'with any other value for :layout' do
    let(:options) { {layout: :basic} }

    specify 'applies Bootstrap attributes of a basic form' do
      expect(form).to include 'role="form"'
    end
  end
end
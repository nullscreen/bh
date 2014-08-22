require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe Bh::FormForHelper do
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::RecordIdentifier
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  before { I18n.enforce_available_locales = true }

  let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
  let(:user) { User.new }
  let(:errors) { {} }

  describe 'legend' do
    let(:block) { Proc.new {|f| f.legend 'Basic info' } }
    let(:title) { nil }
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
end
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

  describe 'select' do
    let(:block) { Proc.new {|f| f.submit 'Save', options} }
    let(:options) { {} }

    context 'given any layout' do
      let(:layout) { :whatever }

      specify 'applies .btn.btn-primary to the button' do
        expect(form).to include 'input class="btn btn-primary"'
      end

      context 'given a context option, applies the context class' do
        let(:options) { {context: :info} }
        it { expect(form).to include 'input class="btn btn-info"' }
      end
    end

    describe 'given a horizontal layout' do
      let(:layout) { :horizontal }
      specify 'applies form-group to the container, col-sm-offset-3.col-sm-9 to the field container' do
        expect(form).to match %r{<div class="form-group"><div class="col-sm-offset-3 col-sm-9"><input}
      end
    end
  end
end
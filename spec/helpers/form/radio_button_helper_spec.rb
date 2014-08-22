require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'radio_button' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
  let(:user) { User.new }
  let(:errors) { {} }
  let(:block) { Proc.new {|f| f.radio_button :name, 'Jeremy', options} }
  let(:options) { {} }

  context 'given any layout' do
    let(:layout) { :whatever }

    specify 'not given a label option, generates one from the value' do
      expect(form).to include '> Jeremy</label>'
    end

    context 'given a label option, uses the provided one' do
      let(:options) { {label: 'Jerry'} }
      it { expect(form).to include '> Jerry</label>' }
    end

    specify 'not given an error, does not apply has-error to the form group' do
      expect(form).not_to include 'has-error'
    end

    context 'given an error' do
      before { user.errors.add :name, 'cannot be nil' }

      specify 'shows errors and error messages' do
        expect(form).to include 'has-error'
        expect(form).to include '<span class="help-block text-left">cannot be nil</span>'
      end
    end
  end

  describe 'given a basic layout' do
    let(:layout) { :basic }
    specify 'applies radio to the container, and an inline label' do
      expect(form).to match %r{<div class="radio"><label><input.+? /> Jeremy</label></div>}
    end
  end

  describe 'given a horizontal layout' do
    let(:layout) { :horizontal }
    specify 'applies form-group to the outer container, .col-sm-offset-3.col-sm-9 to the field container, radio to the container, and an inline label' do
      expect(form).to match %r{<div class="form-group"><div class="col-sm-offset-3 col-sm-9"><div class="radio"><label><input.+? /> Jeremy</label></div></div></div>}
    end
  end

  describe 'given an inline layout' do
    let(:layout) { :inline }
    specify 'applies radio to the container, and an inline label' do
      expect(form).to match %r{<div class="radio"><label><input.+? /> Jeremy</label></div>}
    end

    context 'given an error' do
      before { user.errors.add :name, 'cannot be nil' }

      specify 'applies sr-only to the error message' do
        expect(form).to include '<span class="help-block text-left sr-only">cannot be nil</span>'
      end
    end
  end
end
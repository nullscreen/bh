require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'select' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
  let(:user) { User.new }
  let(:errors) { {} }
  let(:block) { Proc.new {|f| f.select :name, [['Jeremy', 1]], options} }
  let(:options) { {} }

  context 'given any layout' do
    let(:layout) { :whatever }

    specify 'not given a label option, automatically generates one' do
      expect(form).to include 'Name</label>'
    end

    context 'given a label option, uses the provided one' do
      let(:options) { {label: 'Given name'} }
      it { expect(form).to include 'Given name</label>' }
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

      specify 'does not show error icons' do
        expect(form).not_to include 'has-feedback'
      end
    end
  end

  describe 'given a basic layout' do
    let(:layout) { :basic }
    specify 'applies form-group to the container, form-control to the input' do
      expect(form).to match %r{<div class="form-group"><label.+?>Name</label><select class="form-control"}
    end
  end

  describe 'given a horizontal layout' do
    let(:layout) { :horizontal }
    specify 'applies form-group to the container, form-control to the input, col-sm-3.control-label to the label and col-sm-9 to the field container' do
      expect(form).to match %r{<div class="form-group"><label class="col-sm-3 control-label".+?>Name</label><div class="col-sm-9"><select class="form-control"}
    end
  end

  describe 'given an inline layout' do
    let(:layout) { :inline }
    specify 'applies form-group to the container, form-control to the input, sr-only to the label' do
      expect(form).to match %r{<div class="form-group"><label class="sr-only".+?>Name</label><select class="form-control"}
    end

    context 'given an error' do
      before { user.errors.add :name, 'cannot be nil' }

      specify 'applies sr-only to the error message' do
        expect(form).to include '<span class="help-block text-left sr-only">cannot be nil</span>'
      end
    end
  end
end
require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'file_field' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
  let(:user) { User.new }
  let(:errors) { {} }
  let(:block) { Proc.new {|f| f.file_field :name, accept: 'text/html'} }

  describe 'given a basic layout' do
    let(:layout) { :basic }
    specify 'applies form-group to the container to the input' do
      expect(form).to match %r{<div class="form-group"><label.+?>Name</label><(input|textarea)}
    end

    specify 'does not apply form-control to the input' do
      expect(form).not_to match 'form-control'
    end
  end

  describe 'given a horizontal layout' do
    let(:layout) { :horizontal }
    specify 'applies form-group to the container, col-sm-3.control-label to the label and col-sm-9 to the field container' do
      expect(form).to match %r{<div class="form-group"><label class="col-sm-3 control-label".+?>Name</label><div class="col-sm-9"><(input|textarea)}
    end

    specify 'does not apply form-control to the input' do
      expect(form).not_to match 'form-control'
    end
  end

  describe 'given an inline layout' do
    let(:layout) { :inline }
    specify 'applies form-group to the container, sr-only to the label' do
      expect(form).to match %r{<div class="form-group"><label class="sr-only".+?>Name</label><(input|textarea)}
    end

    specify 'does not apply form-control to the input' do
      expect(form).not_to match 'form-control'
    end

    context 'given an error' do
      before { user.errors.add :name, 'cannot be nil' }

      specify 'applies sr-only to the error message' do
        expect(form).to include '<span class="help-block text-left sr-only">cannot be nil</span>'
      end
    end
  end
end
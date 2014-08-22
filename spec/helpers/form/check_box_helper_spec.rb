require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'check_box' do
  attr_accessor :output_buffer
  let(:protect_against_forgery?) { false }
  let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
  let(:user) { User.new }
  let(:errors) { {} }
  let(:block) { Proc.new {|f| f.check_box :name, options} }
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
    end
  end

  describe 'given a basic layout' do
    let(:layout) { :basic }
    specify 'applies checkbox to the container, and an inline label' do
      expect(form).to match %r{<div class="checkbox"><label><input.+? /> Name</label></div>}
    end

    context 'given the inline_label: false option' do
      let(:options) { {inline_label: false} }

      specify 'aligns the label on top of the check-box' do
        expect(form).to match %r{<label for="user_name">Name</label><input}
        expect(form).to include 'input class="form-control"'
      end
    end
  end

  describe 'given a horizontal layout' do
    let(:layout) { :horizontal }
    specify 'applies form-group to the outer container, .col-sm-offset-3.col-sm-9 to the field container, checkbox to the container, and an inline label' do
      expect(form).to match %r{<div class="form-group"><div class="col-sm-offset-3 col-sm-9"><div class="checkbox"><label><input.+? /> Name</label></div></div></div>}
    end

    context 'given the inline_label: false option' do
      let(:options) { {inline_label: false} }

      specify 'aligns the label on top of the check-box' do
        expect(form).to match %r{<label class="col-sm-3 control-label" for="user_name">Name</label><div class="col-sm-9"><input}
        expect(form).to include 'input class="form-control checkbox"'
      end
    end
  end

  describe 'given an inline layout' do
    let(:layout) { :inline }
    specify 'applies checkbox to the container, and an inline label' do
      expect(form).to match %r{<div class="checkbox"><label><input.+? /> Name</label></div>}
    end

    context 'given an error' do
      before { user.errors.add :name, 'cannot be nil' }

      specify 'applies sr-only to the error message' do
        expect(form).to include '<span class="help-block text-left sr-only">cannot be nil</span>'
      end
    end

    context 'given the inline_label: false option' do
      let(:options) { {inline_label: false} }

      specify 'aligns the label on top of the check-box' do
        expect(form).to match %r{<label class="sr-only" for="user_name">Name</label><input}
        expect(form).not_to include 'form-control'
      end
    end
  end
end
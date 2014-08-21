require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper
include ActionView::Helpers::FormOptionsHelper
include ActionView::RecordIdentifier

require 'active_model'
require 'active_support/all'
class User
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name

  def initialize(attributes = {})
    @name = attributes[:name]
  end

  def persisted?
    false
  end
end


describe Bh::FormBuilder do
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
  let(:user) { User.new }
  let(:errors) { {} }
  before { I18n.enforce_available_locales = true }

  describe 'text_field' do
    let(:block) { Proc.new {|f| f.text_field :name, options} }
    let(:options) { {} }

    context 'given any layout' do
      let(:layout) { :whatever }

      specify 'not given a placeholder option, automatically generates one' do
        expect(form).to include 'placeholder="Name"'
      end

      context 'given a placeholder option, uses the provided one' do
        let(:options) { {placeholder: 'Given name'} }
        it { expect(form).to include 'placeholder="Given name"' }
      end

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

        specify 'shows errors, error messages and error icons' do
          expect(form).to include '<div class="form-group has-error has-feedback">'
          expect(form).to include '<span class="help-block text-left">cannot be nil</span>'
        end

        context 'given an option to hide error icons, hides error icons' do
          let(:errors) { {icons: false} }
          it{ expect(form).not_to include 'has-feedback' }
        end

        context 'given an option to hide error messages, hides error messages' do
          let(:errors) { {messages: false} }
          it{ expect(form).not_to include 'help-block' }
        end
      end
    end

    describe 'given a basic layout' do
      let(:layout) { :basic }
      specify 'applies form-group to the container, form-control to the input' do
        expect(form).to include '<div class="form-group"><label for="user_name">Name</label><input class="form-control"'
      end
    end

    describe 'given a horizontal layout' do
      let(:layout) { :horizontal }
      specify 'applies form-group to the container, form-control to the input, col-sm-3.control-label to the label and col-sm-9 to the field container' do
        expect(form).to include '<div class="form-group"><label class="col-sm-3 control-label" for="user_name">Name</label><div class="col-sm-9"><input class="form-control"'
      end
    end

    describe 'given an inline layout' do
      let(:layout) { :inline }
      specify 'applies form-group to the container, form-control to the input, sr-only to the label' do
        expect(form).to include '<div class="form-group"><label class="sr-only" for="user_name">Name</label><input class="form-control"'
      end

      context 'given an error' do
        before { user.errors.add :name, 'cannot be nil' }

        specify 'applies sr-only to the error message' do
          expect(form).to include '<span class="help-block text-left sr-only">cannot be nil</span>'
        end
      end
    end
  end
end
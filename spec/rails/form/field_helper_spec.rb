require 'rails_helper'
require 'bh/core_ext/rails/form_for_helper'
include Bh::Rails::Helpers

def self.field_helpers_to_test
  types = %w(email number password phone search telephone text url)
  if defined?(ActionView::VERSION) # only defined in ActionView >=4
    # types.concat %w(color date datetime datetime_local month time week)
  end
  types.map{|type| "#{type}_field"} << "text_area"
end

field_helpers_to_test.each do |form_field|
  describe form_field do
    attr_accessor :output_buffer
    let(:protect_against_forgery?) { false }
    let(:form) { form_for user, layout: layout, errors: errors, url: '/', &block }
    let(:user) { User.new }
    let(:errors) { {} }

    let(:block) { Proc.new {|f| f.send form_field, :name, options} }
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

      context 'not given a help option, does not display a help box' do
        it { expect(form).not_to include 'help-block' }
      end

      context 'given a help option, displays a help box' do
        let(:options) { {help: 'Please write the given name'} }
        it { expect(form).to include '<span class="help-block text-left">Please write the given name</span>' }
      end

      specify 'not given a prefix or suffix option, does not use an input group' do
        expect(form).not_to include 'input-group'
      end

      context 'given a prefix option, prints the prefix before the field' do
        let(:options) { {prefix: 'Mr.'} }
        it { expect(form).to include '<div class="input-group"><span class="input-group-addon">Mr.</span><' }
      end

      context 'given a suffix option, prints the prefix after the field' do
        let(:options) { {suffix: 'Jr'} }
        it { expect(form).to match %r{<div class="input-group"><.+?><span class="input-group-addon">Jr</span></div>}m }
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

        specify 'shows error icons (except for number_field)' do
          expect(form).to include 'has-feedback' unless form_field == 'number_field'
        end

        context 'given an option to hide error icons, hides error icons' do
          let(:errors) { {icons: false} }
          it{ expect(form).not_to include 'has-feedback' }
        end

        context 'given the suffix option, hides error icons (or they would overlap)' do
          let(:options) { {suffix: 'Jr'} }
          it{ expect(form).not_to include 'form-control-feedback' }
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
        expect(form).to match %r{<div class="form-group"><label.+?>Name</label><(input|textarea)(?:| placeholder="Name") class="form-control"}
      end
    end

    describe 'given a horizontal layout' do
      let(:layout) { :horizontal }
      specify 'applies form-group to the container, form-control to the input, col-sm-3.control-label to the label and col-sm-9 to the field container' do
        expect(form).to match %r{<div class="form-group"><label class="col-sm-3 control-label".+?>Name</label><div class="col-sm-9"><(input|textarea)(?:| placeholder="Name") class="form-control"}
      end
    end

    describe 'given an inline layout' do
      let(:layout) { :inline }
      specify 'applies form-group to the container, form-control to the input, sr-only to the label' do
        expect(form).to match %r{<div class="form-group"><label class="sr-only".+?>Name</label><(input|textarea)(?:| placeholder="Name") class="form-control"}
      end

      context 'given a help message' do
        let(:options) { {help: 'Please write the given name'} }

        specify 'applies sr-only to the help message' do
          expect(form).to include '<span class="help-block text-left sr-only">Please write the given name</span>'
        end
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
require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe Bh::FormBuilders::Basic do
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  let(:form) { form_for :user, layout: :basic, url: '/', &block }
  before { I18n.enforce_available_locales = true }

  def self.field_helpers_to_test
    types = %w(email file number password phone search telephone text url)
    if ActionView::VERSION::STRING >= '4.0.0'
      types.concat %w(color date datetime datetime_local month time week)
    end
    types.map{|type| "#{type}_field"} << "text_area"
  end

  field_helpers_to_test.each do |form_field|
    describe form_field do
      let(:block) { Proc.new {|f| f.send form_field, :first_name, options} }
      let(:options) { {} }

      specify 'applies HTML fit the text field in a basic Bootstrap form' do
        expect(form).to include 'div class="form-group"'
        expect(form).to match %r{(input|textarea) class="form-control"}
      end

      specify 'not given a placeholder, automatically generates one' do
        expect(form).to include 'placeholder="First name"'
      end

      context 'given a placeholder option, uses the provided one' do
        let(:options) { {placeholder: 'Given name'} }
        it { expect(form).to include 'placeholder="Given name"' }
      end

      specify 'not given a label, automatically generates one' do
        expect(form).to include 'First name</label>'
      end

      context 'given a label option, uses the provided one' do
        let(:options) { {label: 'Given name'} }
        it { expect(form).to include 'Given name</label>' }
      end
    end
  end

  describe 'fieldset' do
    let(:block) { Proc.new {|f| f.fieldset title, &Proc.new {}} }
    let(:title) { nil }

    specify 'adds a <fieldset> that looks like a Bootstrap panel' do
      expect(form).to include 'fieldset class="panel panel-default">'
    end

    context 'given a title, adds the title in the panel heading' do
      let(:title) { 'Info' }
      it { expect(form).to include '<div class="panel-heading">Info</div>' }
    end

    specify 'not given a title, does not add a panel heading' do
      expect(form).not_to include 'panel-heading'
    end
  end

  describe 'fields_for' do
    let(:block) { Proc.new {|f| f.fields_for :address, &address_block} }
    let(:address_block) { Proc.new {|f| f.text_field :city} }

    specify 'adds a <fieldset> that looks like a Bootstrap panel' do
      expect(form).to include 'fieldset class="panel panel-default">'
    end

    context 'adds a title in the panel heading' do
      it { expect(form).to include '<div class="panel-heading">Address</div>' }
    end
  end

  describe 'submit' do
    let(:block) { Proc.new {|f| f.submit 'Go!', context: :info} }

    specify 'applies the :context class to the submit button' do
      expect(form).to include 'input class="btn btn-info"'
    end
  end

  describe 'legend' do
    let(:block) { Proc.new {|f| f.legend 'Basic info'} }

    specify 'adds a <legend> to the form' do
      expect(form).to include '<div class="form-group"><legend>Basic info</legend></div>'
    end
  end
end
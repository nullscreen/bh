require 'rails_helper'
require 'bh/core_ext/rails/form_for_helper'
include Bh::Rails::Helpers

describe 'fields_for' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for user, layout: layout, url: '/', &block }
  let(:user) { User.new }
  let(:layout) { :whatever }
  let(:block) { Proc.new {|f| f.fields_for :address, options, &fields_block } }
  let(:options) { {} }
  let(:title) { nil }
  let(:fields_block) { Proc.new {|f| f.text_field :street } }

  describe 'with the :fieldset option' do
    specify 'not set, wraps the fields in a <fieldset> styled like a panel' do
      expect(form).to include 'fieldset class="panel panel-default">'
    end

    describe 'set to true, wraps the fields in a <fieldset> styled like a panel' do
      let(:options) { {fieldset: true} }
      it { expect(form).to include 'fieldset class="panel panel-default">' }
    end

    describe 'set to false, does not wrap the fields in a <fieldset>' do
      let(:options) { {fieldset: false} }
      it { expect(form).not_to include 'fieldset' }
    end
  end

  describe 'with the :title option' do
    specify 'not set, generates a title from the field name' do
      expect(form).to include '<div class="panel-heading">Address</div>'
    end

    context 'set to a value, uses the value as the panel title' do
      let(:options) { {title: 'Your address'} }
      it { expect(form).to include '<div class="panel-heading">Your address</div>' }
    end
  end

  describe 'with the :layout option' do
    specify 'not set, inherits the layout options of the parent form' do
      expect(form).to match %r{<div class="form-group"><label for.+?>Street</label>}
    end

    context 'set to a value, uses the value as the layout' do
      let(:options) { {layout: :horizontal} }
      it { expect(form).to match %r{<div class="form-group"><label class="col-sm-3 control-label" for.+?>Street</label>} }
    end
  end

  context 'given a record object' do
    let(:block) { Proc.new {|f| f.fields_for :address, user.name, options, &fields_block } }

    specify 'and no other options, uses the provided record object' do
      expect(form).to include 'fieldset class="panel panel-default">'
    end

    context 'and other options, uses the provided record object and options' do
      let(:options) { {title: 'Your address'} }
      it { expect(form).to include '<div class="panel-heading">Your address</div>' }
    end
  end
end
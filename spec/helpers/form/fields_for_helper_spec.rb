require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'fields_for' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for user, layout: layout, url: '/', &block }
  let(:user) { User.new }
  let(:layout) { :whatever }
  let(:block) { Proc.new {|f| f.fields_for :address, options, &fields_block } }
  let(:options) { {} }
  let(:title) { nil }
  let(:fields_block) { Proc.new {|f| f.text_field :street } }

  specify 'adds a <fieldset> that looks like a Bootstrap panel' do
    expect(form).to include 'fieldset class="panel panel-default">'
  end

  context 'given a title option, uses the provided title' do
    let(:options) { {title: 'Your address'} }
    it { expect(form).to include '<div class="panel-heading">Your address</div>' }
  end

  specify 'not given a title, generates one from the field name' do
    expect(form).to include '<div class="panel-heading">Address</div>'
  end

  specify 'given no layout, inherits the layout options of the parent form' do
    expect(form).to match %r{<div class="form-group"><label for.+?>Street</label>}
  end

  context 'given a layout, uses its own layout' do
    let(:options) { {layout: :horizontal} }
    it { expect(form).to match %r{<div class="form-group"><label class="col-sm-3 control-label" for.+?>Street</label>} }
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
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
  let(:layout) { :whatever }
  let(:errors) { {inline: true} }

  describe 'fields_for' do
    let(:block) { Proc.new {|f| f.fields_for :address, options, &fields_block } }
    let(:options) { {} }
    let(:title) { nil }
    let(:fields_block) { Proc.new {|f| f.text_field :street } }

    specify 'adds a <fieldset> that looks like a Bootstrap panel' do
      expect(form).to include 'fieldset class="panel panel-default">'
    end

    specify 'generates a title in the panel heading from the field name' do
      expect(form).to include '<div class="panel-heading">Address</div>'
    end

    specify 'given no layout, inherits the layout options of the parent form' do
      expect(form).to match %r{<div class="form-group"><label for.+?>Street</label>}
    end

    context 'given a layout, uses its own layout' do
      let(:options) { {layout: :horizontal} }
      it { expect(form).to match %r{<div class="form-group"><label class="col-sm-3 control-label" for.+?>Street</label>} }
    end
  end
end
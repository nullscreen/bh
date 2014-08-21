require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe Bh::FormBuilders::Horizontal do
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  let(:form) { form_for :object, layout: :horizontal, url: '/', &block }
  before { I18n.enforce_available_locales = true }

  describe 'text_field' do
    let(:block) { Proc.new {|f| f.text_field :first_name, options} }
    let(:options) { {} }

    specify 'applies HTML fit the text field in a horizontal Bootstrap form' do
      expect(form).to include 'label class="col-sm-3 control-label"'
      expect(form).to include 'div class="col-sm-9"><input'
    end
  end
end
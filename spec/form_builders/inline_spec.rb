require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe Bh::FormBuilders::Inline do
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  let(:form) { form_for :object, layout: :inline, url: '/', &block }
  before { I18n.enforce_available_locales = true }

  describe 'text_field' do
    let(:block) { Proc.new {|f| f.text_field :first_name, options} }
    let(:options) { {} }

    specify 'applies HTML fit the text field in an inline Bootstrap form' do
      expect(form).to include 'label class="sr-only"'
    end
  end
end
require 'spec_helper'
require 'bh/helpers/form_for_helper'
include Bh::FormForHelper

describe 'static_control' do
  let(:protect_against_forgery?) { false }
  let(:form) { form_for User.new, layout: layout, url: '/', &block }
  let(:block) { Proc.new {|f| f.static_control 'user@example.com', options } }
  let(:options) { {} }

  context 'given any layout' do
    let(:layout) { :whatever }

    specify 'adds a paragraph with the static control' do
      expect(form).to include '<div class="form-group"'
      expect(form).to include '<p class="form-control-static">user@example.com</p>'
    end

    context 'given a label option, uses the provided one' do
      let(:options) { {label: 'Email'} }
      it { expect(form).to include 'Email</label>' }
    end

    context 'given the text as a block' do
      let(:block) { Proc.new {|f| f.static_control(label: 'Email') { 'user@example.com' } } }

      specify 'behaves in the same way' do
        expect(form).to include '<div class="form-group"'
        expect(form).to include '<p class="form-control-static">user@example.com</p>'
        expect(form).to include 'Email</label>'
      end
    end
  end

  describe 'given a basic layout and a label' do
    let(:layout) { :basic }
    let(:options) { {label: 'Email'} }
    specify 'uses the provided label' do
      expect(form).to include '<label>Email</label><p'
    end
  end

  describe 'given a horizontal layout' do
    let(:layout) { :horizontal }

    context 'and a label' do
      let(:options) { {label: 'Email'} }

      specify 'applies col-sm-9 to the field container and col-sm-3 to the label' do
        expect(form).to include '<label class="col-sm-3 control-label">Email</label><div class="col-sm-9"><p'
      end
    end

    specify 'and no label, applies col-sm-9.col-sm-offset-3 to the field container' do
      expect(form).to include '<div class="col-sm-9 col-sm-offset-3"><p'
    end
  end

  describe 'given an inline layout and a label' do
    let(:layout) { :inline }
    let(:options) { {label: 'Email'} }

    specify 'applies sr-only to the label' do
      expect(form).to include '<label class="sr-only">Email</label>'
    end
  end
end
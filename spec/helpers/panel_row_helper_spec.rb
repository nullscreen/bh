# encoding: UTF-8

require 'spec_helper'
require 'bh/helpers/panel_row_helper'
require 'bh/helpers/panel_helper'
include Bh::PanelRowHelper
include Bh::PanelHelper

describe 'panel_row' do
  attr_accessor :output_buffer

  describe 'without a block' do
    specify 'shows an empty row' do
      expect(panel_row).to include '<div class="row">'
    end
  end

  describe 'with a block' do
    describe 'that does not include panels' do
      specify 'shows the content of the block in a row' do
        expect(panel_row { 'content' }).to include 'content'
      end
    end

    describe 'that includes panels and the :column_class option' do
      specify 'wraps each panel in a column <div> with the given class' do
        expect(panel_row(column_class: 'col-sm-12') { panel 'content' }).to include '<div class="row"><div class="col-sm-12">'
      end
    end

    describe 'and extra params' do
      specify 'passes the params to the wrapping div' do
        expect(panel_row(class: 'important', data: {value: 1}) { 'content' }).to include '<div class="important row" data-value="1">'
      end
    end
  end
end
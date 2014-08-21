require 'bh/helpers/form/text_field_helper'

module Bh
  class FormBuilder < ActionView::Helpers::FormBuilder
    include Form::TextFieldHelper
  end
end
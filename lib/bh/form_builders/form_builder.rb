require 'bh/helpers/form/field_helper'
require 'bh/helpers/form/check_box_helper'
require 'bh/helpers/form/radio_button_helper'

module Bh
  class FormBuilder < ActionView::Helpers::FormBuilder
    include Form::FieldHelper
    include Form::CheckBoxHelper
    include Form::RadioButtonHelper

    def self.textual_field_helpers
      field_helpers - [:label, :hidden_field, :range_field, :check_box, :radio_button]
    end

    # Use the same template for all the textual field helpers such as
    # email_field, password_field, etc.
    # Exclude the ones that should not have additional styles.
    # Do not show error icons on number_field not to cover the sliders.
    textual_field_helpers.each do |field_type|
      define_method field_type do |method, options = {}|
        field(method, field_type, options) { super method, options }
      end
    end
  end
end
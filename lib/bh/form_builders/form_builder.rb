require 'bh/helpers/form/check_box_helper'
require 'bh/helpers/form/field_helper'
require 'bh/helpers/form/fieldset_helper'
require 'bh/helpers/form/fields_for_helper'
require 'bh/helpers/form/legend_helper'
require 'bh/helpers/form/radio_button_helper'
require 'bh/helpers/form/select_helper'
require 'bh/helpers/form/static_control_helper'
require 'bh/helpers/form/submit_helper'

module Bh
  class FormBuilder < ActionView::Helpers::FormBuilder
    include Form::CheckBoxHelper
    include Form::FieldHelper
    include Form::FieldsetHelper
    include Form::FieldsForHelper
    include Form::LegendHelper
    include Form::RadioButtonHelper
    include Form::SelectHelper
    include Form::StaticControlHelper
    include Form::SubmitHelper

    # @note: field_helpers are returned as symbols in ActionView 4 and as
    #   strings in ActionView 3
    def self.textual_field_helpers
      non_textual_field_helpers = %w(label hidden_field range_field check_box
        radio_button select submit fields_for label)
      field_helpers.map(&:to_s) - non_textual_field_helpers
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
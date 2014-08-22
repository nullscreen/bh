require 'bh/helpers/form/base_helper'

module Bh
  module Form
    module RadioButtonHelper
      include BaseHelper

      def radio_button(method, tag_value, options = {})
        options.merge! offset: true, use_label: false
        options[:label] ||= tag_value
        base_field method, :radio_button, options do
          label_and_field 'radio', method, options do
            super method, tag_value, options
          end
        end
      end
    end
  end
end
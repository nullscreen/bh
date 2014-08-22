require 'bh/helpers/form/base_helper'

module Bh
  module Form
    module LegendHelper
      include BaseHelper

      def legend(value, options = {})
        append_class! options, 'sr-only' if inline_form?
        text = content_tag :legend, value, options
        text = content_tag :div, text, class: 'col-sm-12' if horizontal_form?
        text = label_and_field_container(text, :legend) unless inline_form?
        text
      end
    end
  end
end
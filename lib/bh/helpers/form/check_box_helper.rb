require 'bh/helpers/form/base_helper'

module Bh
  module Form
    module CheckBoxHelper
      include BaseHelper

      def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
        block = -> { super method, options, checked_value, unchecked_value }
        if options.delete(:inline_label) { true }
          check_box_with_inline_label method, options, &block
        else
          check_box_with_block_label method, options, &block
        end
      end

    private

      def check_box_with_block_label(method, options = {}, &block)
        append_class! options, 'form-control' unless inline_form?
        append_class! options, 'checkbox' if horizontal_form?
        options[:label] ||= method.to_s.humanize
        base_field method, :checkbox, options, &block
      end

      def check_box_with_inline_label(method, options = {}, &block)
        options.merge! offset: true, use_label: false
        base_field method, :checkbox, options do
          content_tag :div, class: 'checkbox' do
            content_tag :label, label_and_checkbox(method, options, &block)
          end
        end
      end

      # Rails adds <div class='field_with_errors'> which messes up
      # Bootstrap inline form unless the label is inserted within
      # the div itself.
      def label_and_checkbox(method, options = {}, &block)
        field = @template.capture(&block)
        label = options.delete(:label) || method.to_s.humanize
        if index = field =~ %r{</div>$}
          field.insert index, " #{label}"
        else
          field.concat " #{label}"
        end
      end
    end
  end
end

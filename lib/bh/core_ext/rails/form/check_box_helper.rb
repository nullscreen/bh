require 'bh/core_ext/rails/form/base_helper'

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
        options[:label] ||= default_label_for(method)
        base_field method, :checkbox, options, &block
      end

      def check_box_with_inline_label(method, options = {}, &block)
        options.merge! offset: true, use_label: false
        options[:label] ||= default_label_for(method)
        base_field method, :checkbox, options do
          label_and_field 'checkbox', method, options, &block
        end
      end

      def default_label_for(method)
        if object.class.respond_to?(:human_attribute_name)
          object.class.human_attribute_name(method)
        else
          method.to_s.humanize
        end
      end
    end
  end
end

require 'bh/helpers/form/base_helper'

module Bh
  module Form
    module StaticControlHelper
      include BaseHelper

      def static_control(text_or_options_with_block = nil, options = {}, &block)
        text, options = if block_given?
          [@template.capture(&block), text_or_options_with_block]
        else
          [text_or_options_with_block, options]
        end
        static_control_string text, options || {}
      end

    private

      def static_control_string(text, options = {})
        content_tag :div, class: 'form-group' do
          if inline_form?
              label = content_tag :label, options[:label], class: 'sr-only' if options[:label]
              field = content_tag :p, text, class: 'form-control-static'
              safe_join [label, field].compact
          elsif horizontal_form?
              label = content_tag :label, options[:label], class: 'col-sm-3 control-label' if options[:label]
              field = content_tag :p, text, class: 'form-control-static'
              if options[:label]
              field = content_tag :div, field, class: 'col-sm-9'
              else
                field = content_tag :div, field, class: 'col-sm-9 col-sm-offset-3'
              end
              safe_join [label, field].compact
          else
              label = content_tag :label, options[:label] if options[:label]
              field = content_tag :p, text, class: 'form-control-static'
              safe_join [label, field].compact
          end
        end
      end
    end
  end
end
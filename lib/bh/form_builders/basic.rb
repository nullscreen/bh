require 'action_view'
require 'bh/helpers/panel_helper'

module Bh
  module FormBuilders
    class Basic < ActionView::Helpers::FormBuilder
      include ActionView::Helpers::TagHelper # for content_tag
      include ActionView::Context # for capture
      include ActionView::Helpers::OutputSafetyHelper # for safe_join
      include Bh::PanelHelper # for panel

      def text_field(method, options = {})
        append_class! options, 'form-control'
        options[:placeholder] ||= method.to_s.humanize

        label = label(*[method, options[:label], label_options].compact)
        field = field_container { super method, options }

        content_tag :div, class: 'form-group' do
          safe_join [label, field].compact
        end
      end

      def fieldset(title = nil, &block)
        options = {tag: :fieldset, body: @template.capture(&block)}
        options[:heading] = title if title
        panel options
      end

      def fields_for(record_object = nil, fields_options = {}, &block)
        fieldset record_object.to_s.humanize do
          super record_object, fields_options, &block
        end
      end

    private

      def label_options
      end

      def field_container
        yield
      end

      def append_class!(hash, new_class)
        existing_class = hash[:class]
        hash[:class] = [existing_class, new_class].compact.uniq.join ' '
      end
    end
  end
end
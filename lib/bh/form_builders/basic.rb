require 'action_view'
require 'bh/helpers/panel_helper'

module Bh
  module FormBuilders
    class Basic < ActionView::Helpers::FormBuilder
      include ActionView::Helpers::TagHelper # for content_tag
      include ActionView::Context # for capture
      include ActionView::Helpers::OutputSafetyHelper # for safe_join
      include Bh::PanelHelper # for panel

      field_helpers.each do |form_field|
        define_method form_field do |method, options = {}|
          append_class! options, 'form-control'
          options[:placeholder] ||= method.to_s.humanize
          field(method, options) { super method, options }
        end unless %w(label hidden_field range_field).include?(form_field.to_s)
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

      def submit(value=nil, options={})
        context = options.delete(:context) || 'primary'
        append_class! options, "btn btn-#{context}"
        submit_container { super value, options }
      end

      def legend(value)
        content_tag :div, class: 'form-group' do
          legend_container { content_tag :legend, value }
        end
      end

      def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
        inline_label = options.delete(:inline_label) { true }
        label = options.delete(:label) || method.to_s.humanize
        label = content_tag :label, label, label_options unless inline_label
        append_class! options, 'form-control checkbox' unless inline_label
        field = super method, options, checked_value, unchecked_value = '0'
        check_box_container(inline_label) do
          if inline_label
            field_then_label(field, label, class: 'checkbox')
          else
            label_then_field(label) { field }
          end
        end
      end

      def radio_button(method, tag_value, options = {})
        label = options.delete(:label) || tag_value
        field = super method, tag_value, options
        radio_button_container do
          field_then_label field, label, class: 'radio'
        end
      end

      def select(method, choices = nil, options = {}, html_options = {}, &block)
        append_class! html_options, 'form-control'
        field method, options do
          super method, choices, options, html_options, &block
        end
      end

      def static_control(text_or_options_with_block = nil, options = {}, &block)
        text, label = if block_given?
          [@template.capture(&block), text_or_options_with_block[:label]]
        else
          [text_or_options_with_block, options[:label]]
        end
        label = content_tag :label, label, label_options if label
        field = content_tag :p, text, class: 'form-control-static'
        label_then_field(label) { field }
      end

    private

      def field(method, options = {}, &block)
        label = label(*[method, options.delete(:label), label_options].compact)
        label_then_field label, &block
      end

      def label_then_field(label, &block)
        content_tag :div, class: 'form-group' do
          safe_join [label, field_container(label.nil?, &block)].compact
        end
      end

      def field_then_label(field, label, options = {})
        content_tag :div, options do
          content_tag :label, safe_join([field, label].compact, ' ')
        end
      end

      def label_options
      end

      def field_container(offset)
        yield
      end

      def submit_container
        yield
      end

      def check_box_container(inline_label)
        yield
      end

      def radio_button_container
        yield
      end

      def legend_container
        yield
      end

      def append_class!(hash, new_class)
        existing_class = hash[:class]
        hash[:class] = [existing_class, new_class].compact.uniq.join ' '
      end
    end
  end
end
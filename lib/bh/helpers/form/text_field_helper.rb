require 'action_view'
require 'bh/helpers/glyphicon_helper'

module Bh
  module Form
    module TextFieldHelper
      include ActionView::Helpers::TagHelper # for content_tag
      include ActionView::Context # for capture
      include ActionView::Helpers::OutputSafetyHelper # for safe_join
      include GlyphiconHelper # for glyphicon

      def text_field(method, options = {})
        errors = object.errors.get method if object
        label = label_for method, errors, options
        append_class! options, 'form-control'
        options[:placeholder] ||= method.to_s.humanize
        field = field_container { field_tags super(method, options), errors }
        label_and_field_container safe_join([label, field].compact), errors
      end

    private

      def field_container(&block)
        if horizontal_form?
          content_tag :div, class: 'col-sm-9', &block
        else
          yield
        end
      end

      def field_tags(input_tag, errors)
        tags = [input_tag]
        tags << error_icon_tag if errors.present? && show_error_icon?
        tags << error_help_tag(errors) if errors.present? && show_error_help?
        safe_join tags
      end

      def error_icon_tag
        glyphicon :remove, class: 'form-control-feedback'
      end

      def error_help_tag(errors)
        klass = ['help-block', 'text-left']
        klass << 'sr-only' if inline_form?
        content_tag :span, errors.to_sentence, class: klass.join(' ')
      end

      def label_for(method, errors, options)
        label(*[method, options.delete(:label), label_options(errors)].compact)
      end

      def label_options(errors)
        klass = []
        klass << 'sr-only' if inline_form?
        klass << 'col-sm-3' if horizontal_form?
        klass << 'control-label' if horizontal_form?
        klass << 'control-label' if basic_form? && errors.present?
        {class: klass.join(' ')} if klass.any?
      end

      def label_and_field_container(label_and_field, errors)
        klass = ['form-group']
        if errors.present?
          klass << 'has-error' if errors.present?
          klass << 'has-feedback' if show_error_icon?
        end
        content_tag :div, label_and_field, class: klass.join(' ')
      end

      def show_error_icon?
        @options.fetch(:errors, {}).fetch(:icons, true)
      end

      def show_error_help?
        @options.fetch(:errors, {}).fetch(:messages, :inline).to_s == 'inline'
      end

      def inline_form?
        @options[:layout].to_s == 'inline'
      end

      def horizontal_form?
        @options[:layout].to_s == 'horizontal'
      end

      def basic_form?
        !inline_form? && !horizontal_form?
      end

      def append_class!(hash, new_class)
        existing_class = hash[:class]
        hash[:class] = [existing_class, new_class].compact.uniq.join ' '
      end
    end
  end
end
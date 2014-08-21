require 'bh/helpers/glyphicon_helper'

module Bh
  module Form
    module FieldHelper
      include GlyphiconHelper # for glyphicon

      def field(method, field_type, options = {}, &block)
        errors = (object.errors.get method if object) || {}
        label = label_for method, errors, options
        append_class! options, 'form-control'
        options[:placeholder] ||= method.to_s.humanize
        field = field_container { field_tags errors, field_type, &block }
        label_and_field = safe_join [label, field].compact
        label_and_field_container label_and_field, field_type, errors
      end

    private

      def field_container(&block)
        if horizontal_form?
          content_tag :div, class: 'col-sm-9', &block
        else
          yield
        end
      end

      def field_tags(errors, field_type, &block)
        tags = [@template.capture(&block)]
        tags << error_icon_tag if errors.any? && show_error_icon?(field_type)
        tags << error_help_tag(errors) if errors.any? && show_error_help?
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
        klass << 'control-label' if basic_form? && errors.any?
        {class: klass.join(' ')} if klass.any?
      end

      def label_and_field_container(label_and_field, field_type, errors)
        klass = ['form-group']
        if errors.any?
          klass << 'has-error'
          klass << 'has-feedback' if show_error_icon?(field_type)
        end
        content_tag :div, label_and_field, class: klass.join(' ')
      end

      def show_error_icon?(field_type)
        has_arrows = [:number_field].include? field_type
        @options.fetch(:errors, {}).fetch(:icons, true) && !has_arrows
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
    end
  end
end
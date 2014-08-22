require 'bh/helpers/glyphicon_helper'

module Bh
  module Form
    module BaseHelper
      include GlyphiconHelper # for glyphicon

    private

      def base_field(method, field_type, options = {}, &block)
        errors = (object.errors.get method if object) || {}
        label = label_for method, errors, options
        field = field_container(options) do
          field_tags errors, field_type, options, &block
        end
        label_and_field = safe_join [label, field].compact
        label_and_field_container label_and_field, field_type, errors
      end


      def field_container(options = {}, &block)
        if horizontal_form?
          klass = [('col-sm-offset-3' if options[:offset]), 'col-sm-9']
          content_tag :div, class: klass.compact.join(' '), &block
        else
          yield
        end
      end

      def field_tags(errors, field_type, options = {}, &block)
        prefix, suffix = options.delete(:prefix), options.delete(:suffix)
        field = @template.capture(&block)
        tags = [field_in_group(field, prefix, suffix)]
        tags << error_icon_tag if show_error_icon?(field_type, errors, suffix)
        tags << error_help_tag(errors) if errors.any? && show_error_help?
        safe_join tags
      end

      def field_in_group(field, prefix, suffix)
        input_group_container(prefix || suffix) do
          safe_join [input_addon(prefix), field, input_addon(suffix)].compact
        end
      end

      def input_addon(addon)
        content_tag :span, addon, class: 'input-group-addon' if addon
      end

      def input_group_container(has_addons, &block)
        if has_addons
          content_tag :div, class: 'input-group', &block
        else
          yield
        end
      end

      def label_and_field_container(label_and_field, field_type, errors = {})
        klass = ['form-group']
        klass << 'has-error' if errors.any?
        klass << 'has-feedback' if show_error_icon?(field_type, errors)
        content_tag :div, label_and_field, class: klass.join(' ')
      end


      def show_error_icon?(field_type, errors, suffix = nil)
        no_icon = %w(checkbox number_field radio_button select legend)
        hide = no_icon.include?(field_type.to_s)
        errors.any? && @options.fetch(:errors, {}).fetch(:icons, true) && !hide && suffix.nil?
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
        if options.delete(:use_label) { true }
           args = [method, options.delete(:label), label_options(errors)]
           label *args.compact
        end
      end

      def label_options(errors = {})
        klass = []
        klass << 'sr-only' if inline_form?
        klass << 'col-sm-3' if horizontal_form?
        klass << 'control-label' if horizontal_form?
        klass << 'control-label' if basic_form? && errors.any?
        {class: klass.join(' ')} if klass.any?
      end

      # Rails adds <div class='field_with_errors'> which messes up
      # Bootstrap inline form unless the label is inserted within
      # the div itself.
      def label_and_field(container_class, method, options = {}, &block)
        label_and_field = @template.capture(&block)
        label = options.delete(:label)
        if index = label_and_field =~ %r{</div>$}
          label_and_field.insert index, " #{label}"
        else
          label_and_field.concat " #{label}"
        end
        content_tag :div, class: container_class do
          content_tag :label, label_and_field
        end
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

require 'bh/core_ext/rails/base_helper'
require 'bh/helpers/glyphicon_helper'

module Bh
  module Form
    module BaseHelper
      include Bh::Rails::BaseHelper
      include Bh::Helpers

    private

      def base_field(method, field_type, options = {}, &block)
        errors = (object.errors[method] if object) || {}
        label = label_for method, errors, field_type, options
        field = field_container(options) do
          field_tags errors, field_type, options, &block
        end
        label_and_field = safe_join [label, field].compact
        label_and_field_container label_and_field, field_type, errors
      end


      def field_container(options = {}, &block)
        offset = options.delete :offset
        if horizontal_form?
          klass = [('col-sm-offset-3' if offset), 'col-sm-9']
          content_tag :div, class: klass.compact.join(' '), &block
        else
          yield
        end
      end

      def field_tags(errors, field_type, options = {}, &block)
        prefix, suffix = options.delete(:prefix), options.delete(:suffix)
        help_text = options.delete(:help)
        field = @template.capture(&block)
        tags = [field_in_group(field, prefix, suffix)]
        if show_error_icon?(field_type, errors, suffix) && !basic_form?
          tags << error_icon_tag
        end
        if errors.any? && show_error_help?
          tags << help_tag(errors.to_sentence)
        elsif help_text
          tags << help_tag(help_text)
        end
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

      def help_tag(help_text)
        klass = ['help-block', 'text-left']
        klass << 'sr-only' if inline_form?
        content_tag :span, help_text, class: klass.join(' ')
      end

      # Rails wraps the label in <div class='field_with_errors'> in case of
      # error, which messes up the error icon in Bootstrap basic forms unless
      # the icon is appended to the label itself, rather than at the end.
      def label_for(method, errors, field_type, options)
        if options.delete(:use_label) { true }
          args = [method, options.delete(:label), label_options(errors)]
          label(*args.compact).tap do |label|
            error_icon = show_error_icon? field_type, errors, options[:suffix]
            if (index = label =~ %r{</div>$}) && error_icon && basic_form?
              label.insert index, error_icon_tag
            end
          end
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
        label = safe_join [' ' , options.delete(:label)]
        label_options = options.delete(:label_options) || {}

        label_and_field = @template.capture(&block)
        if index = label_and_field =~ %r{</div>$}
          label_and_field.insert index, label
        else
          label_and_field.concat label
        end
        content_tag :div, class: container_class do
          content_tag :label, label_and_field, label_options
        end
      end

      def show_error_help?
        @options.fetch(:errors, {}).fetch(:messages, :inline).to_s == 'inline'
      end

      def inline_form?
        ['inline', 'navbar'].include? @options[:layout].to_s
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

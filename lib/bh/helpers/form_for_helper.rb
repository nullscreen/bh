require 'action_view'
require 'bh/form_builders/basic'
require 'bh/form_builders/horizontal'
require 'bh/form_builders/inline'

module Bh
  module FormForHelper
    include ActionView::Helpers::FormHelper # for form_for

    def form_for(record, options = {}, &block)
      add_form_options!(options) if options[:layout]
      super record, options, &block
    end

  private

    def add_form_options!(options)
      options[:html] ||= {}
      options[:html].merge! role: 'form'
      append_class! options[:html], class_for(options[:layout])
      options.merge! builder: builder_for(options[:layout])
    end

    def builder_for(layout)
      case layout.to_s
        when 'inline' then FormBuilders::Inline
        when 'horizontal' then FormBuilders::Horizontal
        else FormBuilders::Basic
      end
    end

    def class_for(layout)
      case layout.to_s
        when 'inline' then 'form-inline'
        when 'horizontal' then 'form-horizontal'
      end
    end

    def append_class!(hash, new_class)
      existing_class = hash[:class]
      hash[:class] = [existing_class, new_class].compact.join ' '
    end
  end
end
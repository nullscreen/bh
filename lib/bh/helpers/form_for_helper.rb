require 'bh/helpers/base_helper'
require 'bh/form_builders/form_builder'

module Bh
  module FormForHelper
    include BaseHelper
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
      options.merge! builder: FormBuilder
    end

    def class_for(layout)
      case layout.to_s
        when 'inline' then 'form-inline'
        when 'horizontal' then 'form-horizontal'
      end
    end
  end
end
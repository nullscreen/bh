require 'bh/core_ext/rails/form/fieldset_helper'

module Bh
  module Form
    module FieldsForHelper
      include BaseHelper
      include FieldsetHelper # for fieldset

      def fields_for(record_name, record_object = nil, fields_options = {}, &block)
        if record_object.is_a?(Hash) && record_object.extractable_options?
          record_object, fields_options = nil, record_object
        end

        fields_options[:layout] ||= @options[:layout] if @options.has_key?(:layout)
        fields_options[:errors] ||= @options[:errors] if @options.has_key?(:errors)
        title = fields_options.delete(:title) { record_name.to_s.humanize }
        wrap_in_fieldset = fields_options.fetch :fieldset, true
        fields = super record_name, record_object, fields_options, &block
        wrap_in_fieldset ? fieldset(title) { fields } : fields
      end
    end
  end
end

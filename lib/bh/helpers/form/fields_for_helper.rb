require 'bh/helpers/form/fieldset_helper'

module Bh
  module Form
    module FieldsForHelper
      include BaseHelper
      include FieldsetHelper # for fieldset

      def fields_for(record_object = nil, fields_options = {}, &block)
        fields_options[:layout] ||= @options[:layout]
        fields_options[:errors] ||= @options[:errors]
        fieldset record_object.to_s.humanize do
          super record_object, fields_options, &block
        end
      end
    end
  end
end
require 'bh/core_ext/rails/form/base_helper'

module Bh
  module Form
    module FieldHelper
      include BaseHelper

      def field(method, field_type, options = {}, &block)
        options[:placeholder] ||= strip_tags(label method)
        append_class! options, 'form-control'
        base_field method, field_type, options, &block
      end
    end
  end
end
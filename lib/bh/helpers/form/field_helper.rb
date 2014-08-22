require 'bh/helpers/form/base_helper'
require 'bh/helpers/glyphicon_helper'

module Bh
  module Form
    module FieldHelper
      include BaseHelper
      include GlyphiconHelper # for glyphicon

      def field(method, field_type, options = {}, &block)
        options[:placeholder] ||= method.to_s.humanize
        append_class! options, 'form-control'
        base_field method, field_type, options, &block
      end
    end
  end
end
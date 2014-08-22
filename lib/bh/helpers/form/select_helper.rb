require 'bh/helpers/form/base_helper'

module Bh
  module Form
    module SelectHelper
      include BaseHelper

      def select(method, choices = nil, options = {}, html_options = {}, &block)
        append_class! html_options, 'form-control'
        base_field method, :select, options do
          super method, choices, options, html_options, &block
        end
      end
    end
  end
end
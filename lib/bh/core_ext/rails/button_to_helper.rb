require 'bh/core_ext/rails/base_helper'
require 'bh/classes/navbar'
require 'bh/classes/stack'

module Bh
  module Rails
    module Helpers
      include BaseHelper

      # Overrides ActionView +button_to+ to be able to add the 'btn' class
      # to the link (or 'navbar-btn' if inside a navbar).
      # @see http://getbootstrap.com/css/#buttons
      # @see http://getbootstrap.com/components/#navbar-buttons
      def button_to(*args, &block)
        args = append_class_as! :class, 'btn', *args, &block
        if Bh::Stack.find(Bh::Navbar)
          args = append_class_as! :form_class, 'navbar-form', *args, &block
        end
        super *args, &block
      end
    end
  end
end
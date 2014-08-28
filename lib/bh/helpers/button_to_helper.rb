require 'bh/helpers/base_helper'

module Bh
  module ButtonToHelper
    include BaseHelper

    # Overrides ActionView +button_to+ to be able to add the 'btn' class
    # to the link (or 'navbar-btn' if inside a navbar).
    # @see http://getbootstrap.com/css/#buttons
    # @see http://getbootstrap.com/components/#navbar-buttons
    def button_to(*args, &block)
      args = append_class_as! :class, 'btn', *args, &block
      if @navbar_id
        args = append_class_as! :form_class, 'navbar-form', *args, &block
      end
      super *args, &block
    end
  end
end
require 'bh/classes/button_to'
require 'bh/classes/navbar'
require 'bh/classes/stack'

module Bh
  module Rails
    module Helpers
      # Overrides ActionView +button_to+ to be able to add the 'btn' class
      # to the link (or 'navbar-btn' if inside a navbar).
      # @see http://getbootstrap.com/css/#buttons
      # @see http://getbootstrap.com/components/#navbar-buttons
      def button_to(*args, &block)
        button_to = Bh::ButtonTo.new self, *args, &block
        button_to.append_class! :btn
        if Bh::Stack.find(Bh::Navbar)
          button_to.append_class_as! :form_class, :'navbar-form'
        end

        # @note: only Rails >=4, button_to accepts block
        if defined?(ActionView::VERSION) && block_given?
          super button_to.url, button_to.attributes, &-> { button_to.content }
        else
          super button_to.content, button_to.url, button_to.attributes, &nil
        end
      end
    end
  end
end
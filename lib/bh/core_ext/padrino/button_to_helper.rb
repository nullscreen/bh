require 'bh/classes/button_to'
require 'bh/classes/navbar'
require 'bh/classes/stack'

module Bh
  module Padrino
    module Helpers
      # Overrides PadrinoHelpers +button_to+ to be able to add the 'btn' class
      # to the link (or 'navbar-btn' if inside a navbar).
      # @see http://getbootstrap.com/css/#buttons
      # @see http://getbootstrap.com/components/#navbar-buttons
      def button_to(*args, &block)
        button_to = Bh::ButtonTo.new self, *args, &block
        button_to.extract! :context, :size, :layout
        button_to.append_class_to! :submit_options, :btn
        button_to.append_class_to! :submit_options, button_to.context_class
        button_to.append_class_to! :submit_options, button_to.size_class
        button_to.append_class_to! :submit_options, button_to.layout_class
        button_to.append_class! :'navbar-form' if Bh::Stack.find(Bh::Navbar)

        if block_given?
          super button_to.url, button_to.attributes, &-> { button_to.content }
        else
          super button_to.content, button_to.url, button_to.attributes, &nil
        end
      end
    end
  end
end
require 'bh/classes/navbar'
require 'bh/classes/vertical'

module Bh
  module Helpers
    # Displays the non-collapsable portion of a Bootstrap-styled navbar.
    # @see http://getbootstrap.com/components/#navbar
    # @return [String] the HTML to display the non-collapsable portion of a
    #   Bootstrap-styled navbar.
    # @overload vertical(content, options = {})
    #   @param [#to_s] content the non-collapsable content to display in the
    #     navbar.
    #   @param [Hash] options the options to pass to the wrapping `<div>`.
    # @overload vertical(options = {}, &block)
    #   @param [Hash] options the options to pass to the wrapping `<div>`.
    #   @yieldreturn [#to_s] the non-collapsable content to display in the
    #     navbar.
    # @example Display a navbar a non-collapsable links.
    #   navbar do
    #     vertical do
    #       link_to 'Home', '/'
    #     end
    #   end
    def vertical(*args, &block)
      if navbar = Bh::Stack.find(Bh::Navbar)
        vertical = Bh::Vertical.new self, *args, &block
        vertical.append_class! :'navbar-header'
        vertical.prepend_html! vertical.toggle_button(navbar.id)
        vertical.render_tag :div
      end
    end
  end
end
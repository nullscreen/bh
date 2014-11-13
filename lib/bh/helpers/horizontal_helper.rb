require 'bh/classes/navbar'

module Bh
  module Helpers
    # Displays the collapsable portion of a Bootstrap-styled navbar.
    # @see http://getbootstrap.com/components/#navbar
    # @return [String] the HTML to display the collapsable portion of a
    #   Bootstrap-styled navbar.
    # @overload horizontal(content, options = {})
    #   @param [#to_s] content the collapsable content to display in the navbar.
    #   @param [Hash] options the options to pass to the wrapping `<div>`.
    #     Note that the `:id` option is ignored since the id must generated
    #     by the navbar in order to match with the target of the toggle button.
    # @overload horizontal(options = {}, &block)
    #   @param [Hash] options the options to pass to the wrapping `<div>`.
    #   @yieldreturn [#to_s] the collapsable content to display in the navbar.
    # @example Display a navbar with two collapsable links.
    #   navbar do
    #     horizontal do
    #       nav do
    #         link_to 'Home', '/'
    #         link_to 'Profile', '/profile'
    #       end
    #     end
    #   end
    def horizontal(*args, &block)
      if navbar = Bh::Stack.find(Bh::Navbar)
        horizontal = Bh::Base.new self, *args, &block
        horizontal.append_class! :'collapse navbar-collapse'
        horizontal.merge! id: navbar.id
        horizontal.render_tag :div
      end
    end
  end
end
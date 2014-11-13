require 'bh/helpers/horizontal_helper'
require 'bh/helpers/vertical_helper'

module Bh
  module Helpers
    # Displays a Bootstrap-styled navbar.
    # @see http://getbootstrap.com/components/#navbar
    # @return [String] the HTML to display a Bootstrap-styled navbar.
    # @param [Hash] options the options for the navbar. Any option not listed
    #   below is ignored, except for `:id` which is passed as an HTML
    #   attribute to the navbar’s collapsable `<div>`.
    # @option options [Boolean] :fluid (false) whether to use a fluid container
    #   to surround the navbar content.
    # @option options [Boolean] :inverted (false) whether to use an inverted
    #   palette of colors.
    # @option options [#to_s] :position the position of the navbar. Can be
    #   `:top` (alias `:fixed_top`), `:bottom` (alias `:fixed_bottom`) or
    #   `:static` (alias `:static_top`).
    # @option options [#to_s] :padding (70) if position is set to :top or
    #   :bottom, the padding to at the top (or bottom) of <body> to prevent the
    #   navbar from overlaying the content.
    # @yieldreturn [#to_s] the content to display in the navbar.
    # @example Display an inverted navbar with three links.
    #   navbar inverted: true do
    #     vertical do
    #       image_tag('logo')
    #     end
    #     horizontal do
    #       nav do
    #         link_to 'Home', '/'
    #         link_to 'Profile', '/profile'
    #       end
    #     end
    #   end
    def navbar(options = {}, &block)
      navbar = Bh::Navbar.new(self, options, &block)
      navbar.extract! :inverted, :position, :padding, :fluid, :id

      navbar.append_class_to! :navigation, :navbar
      navbar.append_class_to! :navigation, navbar.style_class
      navbar.append_class_to! :navigation, navbar.position_class
      navbar.append_class_to! :div, navbar.layout_class
      navbar.prepend_html! navbar.body_padding_style

      navbar.render_partial 'navbar'
    end
  end
end
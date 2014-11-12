require 'bh/classes/nav'
require 'bh/classes/navbar'

module Bh
  module Helpers
    # Displays a Bootstrap-styled nav.
    # @see http://getbootstrap.com/components/#nav
    # @return [String] the HTML to display a Bootstrap-styled nav.
    # @param [Hash] options the options for the nav. Any option not listed below
    #   is passed as an HTML attribute to the alert’s `<ul>`.
    # @option options [#to_s] :as (:tabs) the style of the nav. Can be `:tabs`
    #   or `:pills`.
    # @option options [#to_s] :layout the layout of the nav. Can be
    #   `:justified` or `:stacked`.
    # @yieldreturn [#to_s] the content to display in the nav.
    # @example Display a pills-styled nav with a link.
    #   nav as: :pills do
    #     link_to 'Home', '/'
    #   end
    def nav(options = {}, &block)
      nav = Bh::Nav.new(self, options, &block)
      nav.extract! :as, :layout

      nav.append_class! :nav
      if Bh::Stack.find(Bh::Navbar)
        nav.append_class! :'navbar-nav'
      else
        nav.merge! role: :tablist
        nav.append_class! nav.style_class
        nav.append_class! nav.layout_class
      end

      nav.render_tag :ul
    end
  end
end
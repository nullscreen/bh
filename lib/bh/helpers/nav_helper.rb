require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include navs.
  # @see http://getbootstrap.com/components/#nav
  module NavHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *navs*.
    #
    # The skeleton of the nav is an unordered list; its content is passed as a
    # block as a list of navigation items.
    # Since the most common use for a nav is to display a menu of links, a
    # variable is set inside the block so that every call to +link_to+
    # generates a link *surrounded by a list item*.
    # @example An justified nav with two links.
    #   nav layout: :justified do
    #     link_to 'Home', '/'
    #     link_to 'Profile', '/profile'
    #   end
    #
    # @return [String] an HTML block tag for a nav.
    # @param [Hash] options the display options for the nav.
    # @option options [#to_s] :as ('tabs') the style to use for the nav.
    #   Valid values are: :tabs and :pills.
    # @option options [#to_s] :layout (nil) if set, the layout of the nav.
    #   Valid values are: :justified and :stacked.
    # @yield block the content of the nav
    # @see http://getbootstrap.com/components/#nav
    def nav(options = {}, &block)
      @nav_link = true
      nav = content_tag :ul, nav_options(options), &block
      nav.tap{ @nav_link = false }
    end

  private

    def nav_options(options = {})
      append_class! options, 'nav'
      if @navbar_id
        append_class! options, 'navbar-nav'
      else
        options[:role] = 'tablist'
        append_class! options, "nav-#{options.fetch :as, 'tabs'}"
        append_class! options, "nav-#{options[:layout]}" if options[:layout]
      end
      options.slice :role, :class
    end
  end
end
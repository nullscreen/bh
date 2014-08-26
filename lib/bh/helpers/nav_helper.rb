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
      nav = content_tag :ul, role: 'tablist', class: nav_class(options), &block
      nav.tap{ @nav_link = false }
    end

    # Overrides ActionView +link_to+ to be able to surround the link in a
    # '<li>' item in case the link is inside of a nav.
    def link_to(*args, &block)
      link = super *args, &block
      @nav_link ? content_tag(:li, link, nav_list_item_options(*args)) : link
    end

  private

    def nav_list_item_options(*args)
      options = (block_given? ? args[0] : args[1]) || {}
      {class: 'active'} if current_page? options
    end

    def nav_class(options = {})
      append_class! options, 'nav'
      append_class! options, "nav-#{options.fetch :as, 'tabs'}"
      append_class! options, "nav-#{options[:layout]}" if options[:layout]
      options[:class]
    end
  end
end
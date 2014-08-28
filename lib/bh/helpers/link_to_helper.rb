require 'bh/helpers/base_helper'

module Bh
  module LinkToHelper
    include BaseHelper

    # Overrides ActionView +link_to+ to be able to add the 'alert-link' class
    # to the link in case the link is inside of an alert.
    # @see http://getbootstrap.com/components/#alerts-links
    # Overrides ActionView +link_to+ to be able to surround the link in a
    # '<li>' item in case the link is inside of a nav.
    # Overrides ActionView +link_to+ to be able to add the 'navbar-brand'
    # class to the link in case the link is inside of an alert.
    def link_to(*args, &block)
      args = add_link_class!('alert-link', *args, &block) if @alert_link
      args = add_link_class!('navbar-brand', *args, &block) if @navbar_vertical
      link = super *args, &block
      @nav_link ? content_tag(:li, link, nav_list_item_options(*args, &block)) : link
    end

  private

    def add_link_class!(new_class, *args, &block)
      append_class_as! :class, new_class, *args, &block
    end

    def nav_list_item_options(*args, &block)
      options = (block_given? ? args[0] : args[1]) || {}
      {class: 'active'} if current_page? options
    end
  end
end

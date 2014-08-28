require 'action_view'

module Bh
  module UrlHelper
    # Overrides ActionView +link_to+ to be able to add the 'alert-link' class
    # to the link in case the link is inside of an alert.
    # @see http://getbootstrap.com/components/#alerts-links
    # Overrides ActionView +link_to+ to be able to surround the link in a
    # '<li>' item in case the link is inside of a nav.
    def link_to(*args, &block)
      args = add_link_class!('alert-link', *args, &block) if @alert_link
      link = super *args, &block
      @nav_link ? content_tag(:li, link, nav_list_item_options(*args, &block)) : link
    end

  private

    def add_link_class!(new_class, *args, &block)
      html_options = (block_given? ? args[1] : args[2]) || {}
      klass = html_options[:class]
      html_options[:class] = [klass, new_class].compact.join ' '
      block_given? ? args[1] = html_options : args[2] = html_options
      args
    end

    def nav_list_item_options(*args, &block)
      options = (block_given? ? args[0] : args[1]) || {}
      {class: 'active'} if current_page? options
    end
  end
end

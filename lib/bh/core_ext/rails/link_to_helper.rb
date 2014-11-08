require 'bh/helpers/base_helper'
require 'bh/classes/alert_box'
require 'bh/classes/dropdown'
require 'bh/classes/nav'
require 'bh/classes/stack'
require 'bh/classes/vertical'

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
      if Bh::Stack.find Bh::AlertBox
        super *add_link_class!('alert-link', *args, &block), &block
      elsif Bh::Stack.find Bh::Vertical
        super *add_link_class!('navbar-brand', *args, &block), &block
      elsif Bh::Stack.find Bh::Dropdown
        content_tag :li, role: :presentation do
          super *add_menu_item_attributes!(*args, &block), &block
        end
      elsif Bh::Stack.find Bh::Nav
        content_tag :li, super(*args, &block), nav_item_options(*args, &block)
      else
        super *args, &block
      end
    end

  private

    def add_link_class!(new_class, *args, &block)
      append_class_as! :class, new_class, *args, &block
    end

    def nav_item_options(*args, &block)
      options = (block_given? ? args[0] : args[1]) || {}
      {class: 'active'} if current_page? options
    end

    def add_menu_item_attributes!(*args, &block)
      html_options = (block_given? ? args[1] : args[2]) || {}
      html_options.reverse_merge! role: 'menuitem', tabindex: '-1'
      block_given? ? args[1] = html_options : args[2] = html_options
      args
    end
  end
end

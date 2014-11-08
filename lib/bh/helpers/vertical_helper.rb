require 'bh/helpers/base_helper'

module Bh
  # Provides the `vertical` helper.
  module VerticalHelper
    include BaseHelper

    def vertical(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        vertical_string (content_or_options_with_block || {}), &block
      else
        vertical_string (options || {}), &Proc.new { content_or_options_with_block }
      end
    end

  private

    # Yields the block as the vertical part of the navbar and sets a variable
    # so that every +link_to+ helper called inside the block gets the
    # "navbar-brand" class added, for links to look better.
    def vertical_string(options = {}, &block)
      @navbar_vertical = true
      append_class! options, 'navbar-header'
      vertical = content_tag :div, options do
        safe_join [toggle_button, capture(&block)], "\n"
      end
      vertical.tap{ @navbar_vertical = false }
    end

    def toggle_button(options = {})
      options['type'] = 'button'
      options['class'] = 'navbar-toggle'
      options['data-toggle'] = 'collapse'
      options['data-target'] =  "##{navbar_id}"
      content_tag :button, options do
        safe_join [toggle_text, toggle_bar, toggle_bar, toggle_bar], "\n"
      end
    end

    def toggle_text
      content_tag :span, 'Toggle navigation', class: 'sr-only'
    end

    def toggle_bar
      content_tag :span, nil, class: 'icon-bar'
    end
  end
end
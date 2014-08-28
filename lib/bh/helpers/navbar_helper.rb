require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include navbars.
  # @see http://getbootstrap.com/components/#navbar
  module NavbarHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *navbars*.
    #
    # The skeleton of the nav is a <div> container inside a <nav> tag; its
    # content is passed as a block.
    #
    # Bootstrap allows to differentiate between the content of a navtab that
    # should remain visible even on a mobile (in a 'vertical' layout) and the
    # content that should only be visible when there is enough horizontal space
    # (in a 'horizontal') layout.
    #
    # The +vertical+ and +horizontal+ helpers can be used inside a navbar to
    # specify these types of content.
    # @example An inverted navbar with the company logo and two links.
    #   navbar inverted: false do
    #     vertical image_tag('logo')
    #     horizontal nav do
    #       link_to 'Home', '/'
    #       link_to 'Profile', '/profile'
    #     end
    #   end
    #
    # @return [String] an HTML block tag for a navbar.
    # @param [Hash] options the display options for the nav.
    # @option options [Boolean] :fluid (false) whether to use a fluid container
    #   to surround the navbar content.
    # @option options [Boolean] :inverted (false) whether to use an inverted
    #   palette of colors.
    # @option options [#to_s] :position (nil) if set, the position of the
    #   navbar. Valid values are: :top (alias :fixed_top), :bottom
    #   (alias :fixed_bottom) and :static (alias :static_top).
    # @option options [#to_s] :padding (70) if position is set to :top or
    #   :bottom, then this padding will be added at the top (or bottom) of
    #   <body> to prevent the navbar from overlaying the content.
    # @yield block the content of the nav
    # @see http://getbootstrap.com/components/#navbar
    def navbar(options = {}, &block)
      @navbar_id = rand 10**7
      nav_tag = navbar_string options, &block
      navbar = safe_join [navbar_style_tag(options), nav_tag].compact, "\n"
      navbar.tap{ @navbar_id = nil }
    end

    def vertical(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        vertical_string (content_or_options_with_block || {}), &block
      else
        vertical_string (options || {}), &Proc.new { content_or_options_with_block }
      end
    end

    def horizontal(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        horizontal_string (content_or_options_with_block || {}), &block
      else
        horizontal_string (options || {}), &Proc.new { content_or_options_with_block }
      end
    end

  private

    def navbar_string(options = {}, &block)
      content_tag :nav, role: 'navigation', class: navbar_class(options) do
        content_tag :div, class: navbar_container_class(options), &block
      end
    end

    # @private
    # The fixed navbar will overlay your other content, unless you add padding
    # to the top or bottom of the <body>. Try out your own values or use our
    # snippet below. Tip: By default, the navbar is 50px high.
    # @see http://getbootstrap.com/components/#navbar-fixed-top
    def navbar_style_tag(options = {})
      padding_value = options.fetch :padding, 70
      if padding_value && padding_type = padding_type_for(options[:position])
        content_tag :style, "body {padding-#{padding_type}: #{padding_value}px}"
      end
    end

    def padding_type_for(position)
      /fixed-(?<type>top|bottom)$/ =~ navbar_position_class_for(position)
      type
    end

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

    def horizontal_string(options = {}, &block)
      append_class! options, 'collapse navbar-collapse'
      options[:id] = navbar_id
      content_tag :div, options, &block
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

  private

    def navbar_id
      "navbar-collapse-#{@navbar_id}"
    end

    def navbar_class(options = {})
      style = options[:inverted] ? 'inverse' : 'default'
      position = navbar_position_class_for options[:position]
      append_class! options, 'navbar'
      append_class! options, "navbar-#{style}"
      append_class! options, "navbar-#{position}" if position
      options[:class]
    end

    def navbar_position_class_for(position)
      case position.to_s
        when 'static', 'static_top' then 'static-top'
        when 'top', 'fixed_top' then 'fixed-top'
        when 'bottom', 'fixed_bottom' then 'fixed-bottom'
      end
    end

    def navbar_container_class(options = {})
      options[:fluid] ? 'container-fluid' : 'container'
    end
  end
end


# STILL TO DO
# 2) Add class to form and button and nav and p inside navbar


#
# <%= navbar do %>
#   <%= vertical do %>
#     <%= link_to image_tag('/assets/fullscreen-standard-logo-white.png', alt: 'Fullscreen'), root_path %>
#   <% end %>
#   <%= horizontal do %>
#     <%= nav do %>
#       <%= link_to 'Campaigns', root_path %>
#       <%= link_to 'Users', users_path if current_user.admin? %>
#     <% end %>
#     <%= nav class: 'navbar-right' do %>
#       <!-- button_to needs to:
#            * be surrounded in <li> AND use navbar-form inside a navbar
#            * add navbar-btn is inside a navbar, else add btn
#       -->
#       <%= button_to 'Sign out', destroy_user_session_path, class: 'btn-link', method: :delete %>
#     <% end %>
#   <% end %>
# <% end if user_signed_in? %>
#

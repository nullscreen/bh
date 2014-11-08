require 'bh/helpers/base_helper'
require 'bh/helpers/horizontal_helper'
require 'bh/helpers/vertical_helper'

module Bh
  # Provides the `navbar` helper.
  module NavbarHelper
    include BaseHelper
    include HorizontalHelper
    include VerticalHelper

    # @see http://getbootstrap.com/components/#navbar
    # @return [String] an HTML block to display a navbar.
    # @example An inverted navbar with the company logo and two links.
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
    # @param [Hash] options the display options for the navbar.
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
    # @yieldreturn [#to_s] the content of the navbar.
    def navbar(options = {}, &block)
      @navbar_id = rand 10**7
      nav_tag = navbar_string options, &block
      navbar = safe_join [navbar_style_tag(options), nav_tag].compact, "\n"
      navbar.tap{ @navbar_id = nil }
    end

  private

    def navbar_string(options = {}, &block)
      content_tag :nav, role: 'navigation', class: navbar_class(options) do
        content_tag :div, class: navbar_container_class(options), &block
      end
    end

    def navbar_id
      "navbar-collapse-#{@navbar_id}"
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
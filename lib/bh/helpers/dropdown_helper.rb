require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include dropdowns.
  # @see http://getbootstrap.com/components/#dropdowns
  # @see http://getbootstrap.com/components/#btn-dropdowns
  module DropdownHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *dropdowns*.
    #
    # The skeleton of the dropdown is an unordered list; its content is passed
    # as block to the list of dropdown items.
    # Since the most common use for a dropdown is to display a menu of links, a
    # variable is set inside the block so that every call to +link_to+
    # generates a link *surrounded by a list item* and with the appropriate
    # menu item attributes.
    # @example A right-aligned dropdown with two links.
    #   <%= dropdown align: :right do %>
    #     <%= link_to 'Home', '/' %>
    #     <%= link_to 'Profile', '/profile' %>
    #   <% end %>
    #
    # @return [String] an HTML block tag for a dropdown.
    # @param [#to_s] caption the caption for the dropdown button.
    # @param [Hash] options the display options for the dropdown.
    # @option options [Boolean] :groupable (true) if true, uses the "btn-group"
    #   class rather than then "dropdown" class, so that multiple dropdown
    #   buttons can be aligned in the same row (as a group of buttons).
    # @option options [Boolean] :split (false) if true, creates a split button
    #   that only toggles the dropdown when clicked on the rightmost part.
    # @option options [#to_s] :direction if set to :up, the dropdown appears
    #   above the button, rather than below.
    # @option options [#to_s] :align if set to :right, the dropdown is aligned
    #   to the right-end of the button, rather than to the left-end.
    # @option options [#to_s] :context (:default) the context for the button,
    #   which determines its color.
    # @option options [#to_s] :size the size of the button.
    # @yield block the content of the dropdown
    # @see http://getbootstrap.com/components/#dropdowns
    # @see http://getbootstrap.com/components/#btn-dropdowns
    def dropdown(caption, options = {}, &block)
      options ||= {}
      options[:id] ||= "dropdown-#{rand 10**10}"
      options[:caption] = caption
      options[:div_class] = dropdown_div_class options
      options[:button_class] = dropdown_button_class options
      options[:list_class] = dropdown_list_class options
      layout = options[:split] ? 'bh/dropdown_split' : 'bh/dropdown'
      @dropdown_link = true
      dropdown = render layout: layout, locals: options, &block
      dropdown.tap{ @dropdown_link = false }
    end

  private

    def dropdown_div_class(options = {})
      group = options.fetch(:groupable, true) ? 'btn-group' : 'dropdown'
      direction = 'dropup' if options[:direction].to_s == 'up'
      [group, direction].compact.join ' '
    end

    def dropdown_list_class(options = {})
      align = 'dropdown-menu-right' if options[:align].to_s == 'right'
      ['dropdown-menu', align].compact.join ' '
    end

    def dropdown_button_class(options = {})
      valid_contexts = %w(primary success info warning danger link)
      context = context_for options[:context], valid: valid_contexts

      size = case options[:size].to_s
        when 'lg', 'large' then 'btn-lg'
        when 'sm', 'small' then 'btn-sm'
        when 'xs', 'extra_small' then 'btn-xs'
      end

      ['btn', "btn-#{context}", size].compact.join ' '
    end
  end
end
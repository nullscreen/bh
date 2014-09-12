require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include Font Awesome.
  # Provides methods to include Glyphicons.
  # @see http://getbootstrap.com/components/#glyphicons
  module IconHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Font Awesome documentation
    # @return [String] an HTML block tag for an icon.
    # @param [#to_s] the name of the icon to display, with either dashes or
    #   underscores to separate multiple words.
    # Returns an HTML block tag that follows the Bootstrap documentation and Font Awesome
    # @return [String] an HTML block tag for a glyphicon or font awesome icon.
    # @param [#to_s] the name of the icon to display, with either dashes or
    #   underscores to separate multiple words.
    # @example Display the "zoom in" glyphicon
    #   icon :zoom_in
    # @example Display the "zoom out" glyphicon
    #   icon 'zoom-out'
    # @example Display the "fire" font awesome icon
    #   icon 'fire', library: :font_awesome
    # # @example Display the "zoom out" font awesome icon with size 2 and fixed width
    #   icon 'fire', library: :font_awesome, size: 2, fixed: true
    def icon(name = nil, options = {})
      prefix = case options.delete(:library).to_s.underscore
        when 'font_awesome' then :fa
        else :glyphicon
      end
      append_class! options, prefix
      append_class! options, "#{prefix}-#{name.to_s.gsub '_', '-'}" if name
      append_icon_options!(options)
      content_tag :span, nil, options
    end
    alias_method :glyphicon, :icon # For backwards compatibility

  private

    def append_icon_options!(options)
      append_class_and_delete_option!(options, :size, "fa-#{options[:size]}x") if options[:size]
      append_class_and_delete_option!(options, :fixed, 'fa-fw') if options[:fixed]
    end

    def append_class_and_delete_option!(options, param, value = '')
      append_class! options, value
      options.delete(param)
    end

  end
end
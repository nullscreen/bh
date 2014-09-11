require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include Font Aswesome.
  module FontAwesomeHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Font Awesome documentation
    # @return [String] an HTML block tag for an icon.
    # @param [#to_s] the name of the icon to display, with either dashes or
    #   underscores to separate multiple words.
    # @example Display the "zoom in" icon
    #   font_awesome :zoom_in
    # @example Display the "zoom out" icon
    #   font_awesome 'zoom-out'
    # @example Display the "zoom out" icon with 2 times the size
    #   font_awesome 'zoom-out', size: 2
    # @example Display the "zoom out" icon with fixed width
    #   font_awesome 'zoom-out', fixed: true
    def font_awesome(name = nil, options = {})
      append_class! options, 'fa'
      append_class! options, "fa-#{name.to_s.gsub '_', '-'}" if name
      append_class_and_delete_option!(options, :size, "fa-#{options[:size]}x") if options[:size]
      append_class_and_delete_option!(options, :fixed, 'fa-fw') if options[:fixed]
      content_tag :span, nil, options
    end

  private

    def append_class_and_delete_option!(options, param, value)
      append_class! options, value
      options.delete(param)
    end
  end
end
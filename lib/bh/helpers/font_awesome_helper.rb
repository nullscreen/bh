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
    def font_awesome(name = nil, options = {})
      append_class! options, 'fa'
      append_class! options, "fa-#{name.to_s.gsub '_', '-'}" if name
      content_tag :i, nil, options
    end
  end
end
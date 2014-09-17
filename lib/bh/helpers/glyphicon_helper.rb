require 'bh/helpers/icon_helper'

module Bh
  # Provides methods to include Glyphicons.
  # @see http://getbootstrap.com/components/#glyphicons
  module GlyphiconHelper
    include IconHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *glyphicons*.
    # @return [String] an HTML block tag for a glyphicon.
    # @param [#to_s] name the name of the icon to display, with either dashes
    #   or underscores to separate multiple words.
    # @param [Hash] options the options passed to the HTML tag that displays
    #   the icon.
    # @example Display the "zoom in" glyphicon
    #   glyphicon :zoom_in
    # @example Display the "zoom out" glyphicon
    #   glyphicon 'zoom-out'
    def glyphicon(name = nil, options = {})
      icon name, options.merge(library: :glyphicons)
    end
  end
end
require 'bh/helpers/icon_helper'

module Bh
  module Helpers
    # Displays any of the 200 glyphicons available in Bootstrap.
    # @deprecated Use {#icon} instead.
    # @see http://getbootstrap.com/components/#glyphicons
    # @return [String] the HTML to display a glyphicon.
    # @param [#to_s] name the name of the icon to display, with either dashes
    #   or underscores to separate multiple words.
    # @param [Hash] options the options to pass to the icon’s `<span>`.
    # @example Display the "zoom-in" glyphicon
    #   glyphicon :zoom_in
    def glyphicon(name = nil, options = {})
      icon name, options.merge(library: :glyphicons)
    end
  end
end
require 'action_view'

module Bh
  # Provides methods to include Glyphicons.
  # @see http://getbootstrap.com/components/#glyphicons
  module GlyphiconHelper
    include ActionView::Helpers::TagHelper # for content_tag
    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *glyphicons*.
    # @return [String] an HTML block tag for a glyphicon.
    # @param [#to_s] the name of the icon to display, with either dashes or
    #   underscores to separate multiple words.
    # @example Display the "zoom in" glyphicon
    #   glyphicon :zoom_in
    # @example Display the "zoom out" glyphicon
    #   glyphicon 'zoom-out'
    def glyphicon(name = nil, options = {})
      glyphicon_class = "glyphicon-#{name.to_s.gsub '_', '-'}" if name
      klass = ['glyphicon', glyphicon_class].compact.join ' '
      content_tag :span, nil, options.merge(class: klass)
    end
  end
end
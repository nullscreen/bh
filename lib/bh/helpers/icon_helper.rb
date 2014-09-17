require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include vector icons from different libraries.
  # @see http://getbootstrap.com/components/#glyphicons
  # @see http://fortawesome.github.io/Font-Awesome/examples/#bootstrap
  module IconHelper
    include BaseHelper

    # Returns an HTML block tag to display a vector icon.
    # @return [String] an HTML block tag for a vector icon.
    # @param [#to_s] name the name of the icon to display, with either dashes
    #   or underscores to separate multiple words.
    # @param [Hash] options the options for the icon tag. The following options
    #   are used by the +icon+ method, while the remaining ones are passed
    #   to the HTML tag that displays the icon.
    # @option options [#to_s] :library (:glyphicons) the vector icon library
    #   to use. Valid values are 'glyphicon', 'glyphicons' (for Glyphicons),
    #   'font-awesome', 'font_awesome' and 'fa' (for Font Awesome).
    # @example Display the "zoom in" glyphicon
    #   icon :zoom_in
    # @example Display the "fire" font awesome icon
    #   icon 'fire', library: :font_awesome
    def icon(name = nil, options = {})
      prefix = library_prefix_for options.delete(:library)
      append_class! options, prefix
      append_class! options, "#{prefix}-#{name.to_s.gsub '_', '-'}" if name
      content_tag :span, nil, options
    end

  private

    def library_prefix_for(name)
      case name.to_s.underscore
        when 'font_awesome' then :fa
        when '', 'glyphicons' then :glyphicon
        else name
      end
    end
  end
end
require 'bh/classes/icon'

module Bh
  # Provides the `icon` helper.
  module IconHelper
    # @see http://getbootstrap.com/components/#glyphicons
    # @see http://fortawesome.github.io/Font-Awesome/examples/#bootstrap
    # @return [String] an HTML block to display a vector (font) icon.
    # @param [#to_s] name the name of the icon to display, with either dashes
    #   or underscores to separate multiple words.
    # @param [Hash] options the options for the icon tag.
    # @option options [#to_s] :library (:glyphicons) the vector icon library
    #   to use. Valid values are 'glyphicon', 'glyphicons' (for Glyphicons),
    #   'font-awesome', 'font_awesome' and 'fa' (for Font Awesome).
    # @example Display the "zoom in" glyphicon with a title
    #   icon :zoom_in, title: 'Zoom'
    # @example Display the "fire" font awesome icon
    #   icon 'fire', library: :font_awesome
    def icon(name = nil, options = {})
      icon = Bh::Icon.new self, nil, options.merge(name: name)
      icon.extract! :library, :name

      icon.append_class! icon.library_class
      icon.append_class! icon.name_class
      icon.render_tag :span


      # prefix = library_prefix_for options.delete(:library)
      # append_class! options, prefix
      # append_class! options, "#{prefix}-#{name.to_s.gsub '_', '-'}" if name
      # content_tag :span, nil, options
    end

  # private
  #
  #   def library_prefix_for(name)
  #     case name.to_s.underscore
  #       when 'font_awesome' then :fa
  #       when '', 'glyphicons' then :glyphicon
  #       else name
  #     end
  #   end
  end
end
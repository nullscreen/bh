require 'bh/classes/icon'

module Bh
  module Helpers
    # Displays a Bootstrap-styled vector icon.
    # @see http://getbootstrap.com/components/#glyphicons
    # @see http://fortawesome.github.io/Font-Awesome/examples/#bootstrap
    # @return [String] the HTML to display a vector (font) icon.
    # @param [#to_s] name the name of the icon to display, with either dashes
    #   or underscores to separate multiple words.
    # @param [Hash] options the options for the icon tag. Any option not
    #   listed below is passed as an HTML attribute to the icon’s `<span>`.
    # @option options [#to_s] :library (:glyphicons) the vector icon library
    #   to use. Valid values are 'glyphicon', 'glyphicons' (for Glyphicons),
    #   'font-awesome', 'font_awesome' and 'fa' (for Font Awesome).
    # @example Display the "fire" font awesome icon with a title
    #   icon 'fire', library: :font_awesome, title: 'Hot'
    def icon(name = nil, options = {})
      icon = Bh::Icon.new self, nil, options.merge(name: name)
      icon.extract! :library, :name

      icon.append_class! icon.library_class
      icon.append_class! icon.name_class
      icon.render_tag :span
    end
  end
end
require 'bh/classes/navbar'
require 'bh/classes/vertical'

module Bh
  # Provides the `vertical` helper.
  module VerticalHelper

    def vertical(*args, &block)
      if navbar = Bh::Stack.find(Bh::Navbar)
        vertical = Bh::Vertical.new self, *args, &block
        vertical.append_class! :'navbar-header'
        vertical.prepend_html! vertical.toggle_button(navbar.id)
        vertical.render_tag :div
      end
    end
  end
end
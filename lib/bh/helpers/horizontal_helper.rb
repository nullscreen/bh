require 'bh/classes/navbar'

module Bh
  module Helpers
    def horizontal(*args, &block)
      if navbar = Bh::Stack.find(Bh::Navbar)
        horizontal = Bh::Base.new self, *args, &block
        horizontal.append_class! :'collapse navbar-collapse'
        horizontal.merge! id: navbar.id
        horizontal.render_tag :div
      end
    end
  end
end
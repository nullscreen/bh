require 'bh/classes/base'

module Bh
  # Provides the `horizontal` helper.
  module HorizontalHelper

    def horizontal(*args, &block)
      horizontal = Bh::Base.new self, *args, &block
      horizontal.append_class! :'collapse navbar-collapse'
      horizontal.merge! id: navbar_id
      horizontal.render_tag :div
    end
  end
end
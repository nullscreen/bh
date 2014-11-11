require 'tilt'
require 'padrino-helpers'

require 'bh/core_ext/padrino/button_to_helper'

# A view that behaves like a Middleman view
class MiddlemanView
  include Padrino::Helpers::OutputHelpers # for capture
  include Padrino::Helpers::TagHelpers # for content_tag
  include Padrino::Helpers::AssetTagHelpers # for link_to
  include Padrino::Helpers::FormHelpers # for button_to

  include Bh::Helpers
  include Bh::Padrino::Helpers

  def test_button_to_with_block
    false
  end
end
require 'tilt'
require 'padrino-helpers'

# A view that behaves like a Middleman view
class MiddlemanView
  include Padrino::Helpers::OutputHelpers # for capture
  include Padrino::Helpers::TagHelpers # for content_tag
  include Padrino::Helpers::AssetTagHelpers # for link_to

  include Bh::Helpers
end
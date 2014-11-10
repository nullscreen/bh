require 'tilt'
require 'padrino-helpers'

require 'bh/helpers/alert_box_helper'
require 'bh/helpers/button_helper'

# A view that behaves like a Middleman view
class MiddlemanMockView
  include Padrino::Helpers::OutputHelpers # for capture
  include Padrino::Helpers::TagHelpers # for content_tag
  include Padrino::Helpers::AssetTagHelpers # for link_to
end

class MiddlemanMockViewWithBh < MiddlemanMockView
  include Bh::AlertBoxHelper
  include Bh::ButtonHelper
end
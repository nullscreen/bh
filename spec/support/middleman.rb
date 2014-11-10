require 'tilt'
require 'padrino-helpers'

require 'bh/helpers/alert_box_helper'
require 'bh/helpers/button_helper'
require 'bh/helpers/cdn_helper'
require 'bh/helpers/dropdown_helper'
require 'bh/helpers/glyphicon_helper'
require 'bh/helpers/horizontal_helper'
require 'bh/helpers/icon_helper'
require 'bh/helpers/modal_helper'
require 'bh/helpers/nav_helper'
require 'bh/helpers/navbar_helper'
require 'bh/helpers/panel_helper'
require 'bh/helpers/panel_row_helper'
require 'bh/helpers/progress_bar_helper'
require 'bh/helpers/vertical_helper'

# A view that behaves like a Middleman view
class MiddlemanView
  include Padrino::Helpers::OutputHelpers # for capture
  include Padrino::Helpers::TagHelpers # for content_tag
  include Padrino::Helpers::AssetTagHelpers # for link_to

  include Bh::Helpers
end
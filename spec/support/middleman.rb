require 'tilt'
require 'padrino-helpers'

require 'bh/helpers/alert_box_helper'
require 'bh/helpers/button_helper'
require 'bh/helpers/dropdown_helper'
require 'bh/helpers/glyphicon_helper'
require 'bh/helpers/icon_helper'
require 'bh/helpers/modal_helper'
require 'bh/helpers/progress_bar_helper'


# A view that behaves like a Middleman view
class MiddlemanView
  include Padrino::Helpers::OutputHelpers # for capture
  include Padrino::Helpers::TagHelpers # for content_tag
  include Padrino::Helpers::AssetTagHelpers # for link_to

  include Bh::AlertBoxHelper
  include Bh::ButtonHelper
  include Bh::DropdownHelper
  include Bh::GlyphiconHelper
  include Bh::IconHelper
  include Bh::ModalHelper
  include Bh::ProgressBarHelper
end
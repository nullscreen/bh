require 'action_dispatch'
require 'active_support'
require 'action_view'
require 'bh/helpers/alert_box_helper'
require 'bh/helpers/button_helper'
require 'bh/helpers/dropdown_helper'
require 'bh/helpers/glyphicon_helper'
require 'bh/helpers/horizontal_helper'
require 'bh/helpers/icon_helper'
require 'bh/helpers/modal_helper'
require 'bh/helpers/nav_helper'
require 'bh/helpers/navbar_helper'
require 'bh/helpers/progress_bar_helper'
require 'bh/helpers/vertical_helper'
require 'bh/core_ext/rails/link_to_helper'

# A view that behaves like a Rails/ActionView view
class RailsView
  include ActionView::Context # for capture
  include ActionView::Helpers::RenderingHelper # for render
  include ActionView::Helpers::TagHelper # for content_tag
  include ActionView::Helpers::UrlHelper # for link_to
  def request
    ActionDispatch::Request.new 'REQUEST_METHOD' => 'GET'
  end

  def initialize
  end

  include Bh::AlertBoxHelper
  include Bh::ButtonHelper
  include Bh::DropdownHelper
  include Bh::GlyphiconHelper
  include Bh::HorizontalHelper
  include Bh::IconHelper
  include Bh::ModalHelper
  include Bh::NavHelper
  include Bh::NavbarHelper
  include Bh::ProgressBarHelper
  include Bh::VerticalHelper

  include Bh::Rails::Helpers
end
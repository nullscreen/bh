require 'bh/helpers/alert_box_helper'
require 'bh/helpers/button_helper'
require 'bh/helpers/cdn_helper'
require 'bh/helpers/dropdown_helper'
require 'bh/helpers/glyphicon_helper'
require 'bh/helpers/icon_helper'
require 'bh/helpers/modal_helper'
require 'bh/helpers/nav_helper'
require 'bh/helpers/navbar_helper'
require 'bh/helpers/panel_helper'
require 'bh/helpers/panel_row_helper'
require 'bh/helpers/progress_bar_helper'

module Bh
  module Extensions
    class MiddlemanExtension < Middleman::Extension
      helpers do
        include AlertBoxHelper
        include ButtonHelper
        include CdnHelper
        include DropdownHelper
        include GlyphiconHelper
        include IconHelper
        include ModalHelper
        include NavHelper
        include NavbarHelper
        include PanelHelper
        include PanelRowHelper
        include ProgressBarHelper
      end
    end
  end
end

::Middleman::Extensions.register(:bh, Bh::Extensions::MiddlemanExtension)
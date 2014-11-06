require 'bh/helpers/alert_helper'
require 'bh/helpers/button_helper'
require 'bh/helpers/button_to_helper'
require 'bh/helpers/cdn_helper'
require 'bh/helpers/dropdown_helper'
require 'bh/helpers/form_for_helper'
require 'bh/helpers/glyphicon_helper'
require 'bh/helpers/icon_helper'
require 'bh/helpers/link_to_helper'
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
        include AlertHelper
        include ButtonHelper
        include ButtonToHelper
        include CdnHelper
        include DropdownHelper
        include FormForHelper
        include GlyphiconHelper
        include IconHelper
        include LinkToHelper
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
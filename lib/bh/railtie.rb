require 'bh/helpers/alert_helper'
require 'bh/helpers/button_to_helper'
require 'bh/helpers/cdn_helper'
require 'bh/helpers/form_for_helper'
require 'bh/helpers/glyphicon_helper'
require 'bh/helpers/link_to_helper'
require 'bh/helpers/modal_helper'
require 'bh/helpers/nav_helper'
require 'bh/helpers/navbar_helper'
require 'bh/helpers/panel_helper'
require 'bh/helpers/panel_row_helper'

module Bh
  class Railtie < Rails::Railtie
    initializer 'bh.add_helpers' do
      ActionView::Base.send :include, AlertHelper
      ActionView::Base.send :include, ButtonToHelper
      ActionView::Base.send :include, CdnHelper
      ActionView::Base.send :include, FormForHelper
      ActionView::Base.send :include, GlyphiconHelper
      ActionView::Base.send :include, LinkToHelper
      ActionView::Base.send :include, ModalHelper
      ActionView::Base.send :include, NavHelper
      ActionView::Base.send :include, NavbarHelper
      ActionView::Base.send :include, PanelHelper
      ActionView::Base.send :include, PanelRowHelper
    end

    initializer 'bh.add_views' do |app|
      views_path = File.dirname(__FILE__) + "/views"
      ActionController::Base.prepend_view_path views_path
    end
  end
end
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
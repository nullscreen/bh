require 'bh/core_ext/rails/button_to_helper'
require 'bh/core_ext/rails/form_for_helper'
require 'bh/core_ext/rails/link_to_helper'

module Bh
  module Extensions
    class Railtie < ::Rails::Railtie
      initializer 'bh.add_helpers' do
        ActionView::Base.send :include, Bh::Helpers
        ActionView::Base.send :include, Bh::Rails::Helpers
      end

      initializer 'bh.add_views' do |app|
        views_path = File.expand_path '../../views', __FILE__
        ActionController::Base.prepend_view_path views_path
      end
    end
  end
end
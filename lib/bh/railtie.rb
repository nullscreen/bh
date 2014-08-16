require 'bh/helpers/alert_helper'
require 'bh/helpers/cdn_helper'
require 'bh/helpers/url_helper'

module Bh
  class Railtie < Rails::Railtie
    initializer 'bh.add_helpers' do
      ActionView::Base.send :include, AlertHelper
      ActionView::Base.send :include, CdnHelper
      ActionView::Base.send :include, UrlHelper
    end
  end
end
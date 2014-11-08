# Bootstrap Helpers
module Bh
end

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

require 'bh/core_ext/railtie' if defined?(Rails)
require 'bh/core_ext/middleman' if defined?(Middleman)

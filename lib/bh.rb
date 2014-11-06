# Bootstrap Helpers
module Bh
end

require 'bh/core_ext/railtie' if defined?(Rails)
require 'bh/core_ext/middleman' if defined?(Middleman)

# Bootstrap Helpers
module Bh
end

# Always require every generic helper
helpers_folder = File.expand_path '../bh/helpers/*_helper.rb', __FILE__
Dir[helpers_folder].each{|file| require file}

# Conditionally require platform-specific helpers
require 'bh/core_ext/railtie' if defined?(Rails)
require 'bh/core_ext/middleman' if defined?(Middleman)

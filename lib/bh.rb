require 'active_support'
require 'active_support/core_ext'

# Bootstrap Helpers
module Bh
  mattr_accessor :framework
end

# Always require every generic helper
helpers_folder = File.expand_path '../bh/helpers/*_helper.rb', __FILE__
Dir[helpers_folder].each{|file| require file}

# Conditionally require platform-specific helpers
extension   = :railtie if defined?(Rails)
extension ||= :middleman if defined?(Middleman)
extension ||= :padrino if defined?(Padrino)
require "bh/core_ext/#{extension}" if extension
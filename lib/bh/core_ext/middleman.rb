module Bh
  # @api private
  # Provides methods to register Bh in third-party applications.
  module Extensions
    # Makes Bootstrap helpers available in Middleman applications.
    #
    # To use Bh in a Middleman app you need 2 steps:
    #
    #   - include bh in the Gemfile
    #   - add `activate :bh` in the `config.rb` file
    #
    # The following class is registered as a Middleman extension, but you still
    # need to activate it in the configuration file to make helpers available.
    class MiddlemanExtension < Middleman::Extension
      helpers do
        include Bh::Helpers
      end
    end
  end

  Bh.framework = :middleman
end

::Middleman::Extensions.register(:bh, Bh::Extensions::MiddlemanExtension)
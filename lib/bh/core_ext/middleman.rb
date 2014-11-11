require 'bh/core_ext/padrino/button_to_helper'

module Bh
  module Extensions
    class MiddlemanExtension < Middleman::Extension
      helpers do
        include Bh::Helpers
        include Bh::Padrino::Helpers
      end
    end
  end
end

::Middleman::Extensions.register(:bh, Bh::Extensions::MiddlemanExtension)
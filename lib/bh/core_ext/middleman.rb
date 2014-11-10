module Bh
  module Extensions
    class MiddlemanExtension < Middleman::Extension
      helpers do
        include Bh::Helpers
      end
    end
  end
end

::Middleman::Extensions.register(:bh, Bh::Extensions::MiddlemanExtension)
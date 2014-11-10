require 'bh/classes/base'

module Bh
  module Classes
    class LinkTo < Base
      def initialize(app = nil, *args, &block)
        @url = extract_url_from(*args, &block)
        super
      end
    end
  end
end

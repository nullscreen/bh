require 'bh/classes/base'

module Bh
  module Classes
    class LinkTo < Base
      def initialize(app = nil, *args, &block)
        @url = extract_url_from(*args, &block)
        super
      end

      def url
        @url
      end

    private

      def extract_url_from(*args)
        args.delete_at(block_given? ? 0 : 1)
      end
    end
  end
end

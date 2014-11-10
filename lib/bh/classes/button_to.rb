require 'bh/classes/link_to'

module Bh
  module Classes
    class ButtonTo < Button
      def initialize(app = nil, *args, &block)
        @url = extract_url_from(*args, &block)
        super
      end
    end
  end
end
require 'bh/classes/base'

module Bh
  module Classes
    class LinkTo < Base
      def initialize(app = nil, *args, &block)
        @url = extract_url_from(*args, &block)
        super
      end

      def current_page?
        case Bh.framework
        when :rails
          @app.current_page? @url
        when :padrino, :middleman
          request = Bh.framework == :middleman ? @app.req : @app.request
          request.path_info == @app.url_for(@url)
        end
      end

      def content
        super if @content
      end
    end
  end
end

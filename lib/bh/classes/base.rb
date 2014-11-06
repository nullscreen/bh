require 'bh/classes/stack'

module Bh
  module Classes
    class Base
      def initialize(app = nil, *args, &block)
        @app = app
        @concat = block_given? &&  @app.respond_to?(:concat_content)
        @options = extract_options_from(*args, &block).dup
        @content = extract_content_from *args, &block
      end

      def extract!(*keys)
        @attributes = @options.slice! *keys
      end

      def merge!(attributes = {})
        html_attributes.merge! attributes
      end

      def append_class!(new_class, hash = html_attributes)
        existing_class = hash[:class]
        hash[:class] = [existing_class, new_class].compact.join ' '
      end

      def prepend_html!(html)
        @content = safe_join [html, @content]
      end

      def render_tag(tag)
        html = @app.content_tag tag, @content, attributes
        render html
      end

    private

      def safe_join(array = [])
        array.compact.join("\n").html_safe
      end

      def stack(&block)
        Stack.unshift self
        yield.tap{ Stack.shift }
      end

      def attributes
        @attributes || @options
      end

      def html_attributes
        @html_attributes || attributes
      end

      def render(html)
        @concat && html ? @app.concat_content(html) : html
      end

      def extract_options_from(*args, &block)
        args.shift unless block_given?
        args.extract_options!
      end

      def extract_content_from(*args, &block)
        if block_given?
          stack { capture_content &block }
        else
          args.shift
        end
      end

      def capture_content(&block)
        ActiveSupport::SafeBuffer.new.safe_concat(@app.capture &block)
      end
    end
  end

  include Classes
end
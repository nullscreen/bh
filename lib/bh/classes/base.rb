require 'bh/classes/stack'
require 'ostruct'
require 'active_support'
require 'active_support/core_ext'

module Bh
  # @api private
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
        @options.any?
      end

      def merge!(attributes = {})
        html_attributes.deep_merge! attributes
      end

      def append_class!(new_class, hash = html_attributes, attribute = :class)
        existing_class = hash[attribute]
        hash[attribute] = [existing_class, new_class].compact.join ' '
      end

      def append_class_to!(key, new_class)
        append_class! new_class, (html_attributes[key] ||= {})
      end

      def prepend_html!(html)
        @content = safe_join [html, @content]
      end

      def render_tag(tag)
        render content_tag(tag)
      end

      def render_partial(partial)
        file = File.expand_path "../../views/bh/_#{partial}.html.erb", __FILE__
        template = ERB.new(File.read file)
        assigns = OpenStruct.new attributes.merge(content: @content)
        render template.result(assigns.instance_eval{ binding &nil }).html_safe
      end

      def tag
        :div
      end

      def attributes
        @attributes || @options
      end

      def content
        items = Array.wrap(@content).map do |item|
          item.is_a?(Base) ? item.content_tag(item.tag) : item
        end
        items.all?(&:html_safe?) ? safe_join(items) : items.join
      end

      def content_tag(tag)
        @app.content_tag tag, content, attributes
      end

      def url
        @url
      end

      def extract_from(option, attributes = [])
        if @options[option]
          @attributes[option] = @options[option].except *attributes
        end
      end

    private

      def safe_join(array = [])
        array.compact.join("\n").html_safe
      end

      def stack(&block)
        Stack.unshift self
        yield.tap{ Stack.shift }
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

      def extract_url_from(*args)
        args.delete_at(block_given? ? 0 : 1)
      end

      def capture_content(&block)
        content = @app.capture &block
        if content.is_a? String
          ActiveSupport::SafeBuffer.new.safe_concat(content)
        end
      end
    end
  end

  include Classes
end
require 'bh/classes/base'

module Bh
  module Classes
    class Panel < Base
      # Differently from other classes, Panel works with no content or block,
      # given that the options[:body] is passed, in which case it functions
      # as the content.
      def initialize(app = nil, *args, &block)
        if args.first.is_a?(Hash) && !block_given?
          args.unshift args.first.delete(:body)
        end

        super
      end

      # @return [#to_s] the content-related class to assign to the panel.
      def context_class
        Panel.contexts[@options[:context]]
      end

      # @return [#to_s] the HTML tag to wrap the panel in.
      def tag
        @options.fetch :tag, :div
      end

      # @return [#to_s] the text to display as the panel header
      def heading
        text = title || @options[:heading]
        @app.content_tag :div, text, class: 'panel-heading' if text
      end

      def merge_html!(html)
        @content ||= html
      end

      def body
        if @options[:body]
          @app.content_tag :div, @options[:body], class: 'panel-body'
        end
      end

    private

      def extract_content_from(*args, &block)
        if block_given?
          super
        else
          @app.content_tag :div, super, class: 'panel-body'
        end
      end

      def title
        if @options[:title]
          @app.content_tag :h3, @options[:title], class: 'panel-title'
        end
      end

      # @return [Hash<Symbol, String>] the class that Bootstrap requires to
      #   append to an panel box based on its context.
      def self.contexts
        HashWithIndifferentAccess.new(:'panel-default').tap do |klass|
          klass[:primary]   = :'panel-primary'
          klass[:success] = :'panel-success'
          klass[:info]    = :'panel-info'
          klass[:warning] = :'panel-warning'
          klass[:danger]  = :'panel-danger'
        end
      end
    end
  end
end
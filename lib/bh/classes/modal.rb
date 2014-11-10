require 'bh/classes/button'

module Bh
  module Classes
    class Modal < Base
      # Differently from other classes, Modal works with no content or block,
      # given that the options[:body] is passed, in which case it functions
      # as the content.
      def initialize(app = nil, *args, &block)
        if args.first.is_a?(Hash) && !block_given?
          args.unshift args.first.delete(:body)
        end

        super
      end

      # @return [#to_s] the context-related class to assign to the modal button.
      def button_context_class
        Button.contexts[@options.fetch(:button, {})[:context]]
      end

      # @return [#to_s] the size-related class to assign to the modal button.
      def button_size_class
        Button.sizes[@options.fetch(:button, {})[:size]]
      end

      # @return [#to_s] the size-related class to assign to the modal dialog.
      def dialog_size_class
        Modal.dialog_sizes[@options[:size]]
      end

      # @return [#to_s] the caption for the modal button.
      def caption
        @options.fetch(:button, {}).fetch :caption, title
      end

      # @return [#to_s] the title to display on top of the modal dialog.
      def title
        @options.fetch :title, 'Modal'
      end

      def id
        @options.fetch :id, "modal-#{rand 10**10}"
      end

    private

      # @return [Hash<Symbol, String>] the classes that Bootstrap requires to
      #   append to the modal dialog for each possible size.
      def self.dialog_sizes
        HashWithIndifferentAccess.new.tap do |klass|
          klass[:large]       = :'modal-lg'
          klass[:lg]          = :'modal-lg'
          klass[:sm]          = :'modal-sm'
          klass[:small]       = :'modal-sm'
        end
      end

      def extract_content_from(*args, &block)
        if block_given?
          super
        else
          @app.content_tag :div, super, class: 'modal-body'
        end
      end
    end
  end
end
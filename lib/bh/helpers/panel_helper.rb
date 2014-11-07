require 'bh/helpers/base_helper'

module Bh
  # Provides the `panel` helper.
  module PanelHelper
    include BaseHelper

    # @see http://getbootstrap.com/components/#panels
    # @return [String] an HTML block to display a panel.
    # @overload panel(content, options = {})
    #   @example An informative panel with plain-text content.
    #   panel body: 'You accepted the Terms of service.', context: :success
    #   @param [#to_s] content the main text to include in the panel.
    #   @param [Hash] options the display options for the panel.
    #   @option options [#to_s] :body the main text to include in the panel.
    #     Using this option is equivalent to using the `content` parameter;
    #     in case both are used, the `content` takes precedence.
    #   @option options [#to_s] :heading the text to include above the body.
    #   @option options [#to_s] :title the text to include above the body,
    #     formatted for more impact than a simple heading.
    #   @option options [#to_s] :context (#to_s) (:default) the contextual
    #     alternative to apply to the panel heading and border. Can be
    #     `:danger`, `:info`, `:primary`, `:success` or `:warning`.
    #   @option options [#to_s] :tag (#to_s) (:div) the HTML tag to wrap the
    #     panel into.
    # @overload panel(options = {}, &content_block)
    #   @example An informative panel with HTML content.
    #   panel context: :success do
    #     content_tag :div, class: 'panel-body' do
    #       content_tag :strong, 'You accepted the Terms of service.'
    #   @yieldreturn [#to_s] the content of the panel.
    def panel(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        panel_string capture(&block), (content_or_options_with_block || {})
      elsif content_or_options_with_block.is_a?(Hash) && options.nil?
        panel_string nil, content_or_options_with_block
      else
        panel_string nil, (options || {}).merge(body: content_or_options_with_block)
      end
    end

  private

    def panel_string(content, options = {})
      content = prepend_optional_body_to content, options
      content = prepend_optional_heading_to content, options
      tag = options.fetch :tag, :div
      content_tag tag, content, class: panel_class(options[:context])
    end

    def panel_class(context = nil)
      valid_contexts = %w(primary success info warning danger)
      context = context_for context, valid: valid_contexts
      "panel panel-#{context}"
    end

    def prepend_optional_body_to(content, options = {})
      body = options[:body]
      body = content_tag :div, body, class: 'panel-body' if body
      safe_join [body, content].compact
    end

    def prepend_optional_heading_to(content, options = {})
      title = if options[:title]
        content_tag :h3, options[:title], class: 'panel-title'
      elsif options[:heading]
        options[:heading]
      end
      heading = content_tag :div, title, class: 'panel-heading' if title
      safe_join [heading, content].compact
    end
  end
end
require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include panels.
  # @see http://getbootstrap.com/components/#panels
  module PanelHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *panels*.
    #
    # The content of the panel can either be passed as the first parameter (in
    # which case, the options are the second parameter), or as a block (in
    # which case, the options are the first paramter).
    # @example An panel with plain-text content passed as the first parameter.
    #   panel 'Your profile was updated!', context: :info, title: 'Profile'
    # @example A panel with HTML content passed as a block.
    #   panel context: :info, title: 'Profile'
    #     content_tag :strong, "Your profile was updated!"
    #   end
    #
    # @return [String] an HTML block tag for a panel.
    # @param [String] content_or_options_with_block the content to display in
    #   the panel.
    # @param [Hash] options the display options for the panel.
    # @option options [#to_s] :context (:default) the contextual alternative to
    #   apply to the panel depending on its importance. Can be :default,
    #   :primary, :success, :info, :warning  or :danger.
    # @option options [#to_s] :body if present, the panel will include the
    #   provided text wrapped in a 'panel-body' block, for proper padding
    # @see http://getbootstrap.com/components/#panels-basic
    # @option options [#to_s] :heading if present, the panel will include a
    #   heading with the provided text.
    # @option options [#to_s] :title if present, the panel will include a
    #   heading with the provided text wrapped in a 'panel-title' block, for
    #   proper title styling and link coloring.
    # @option options [#to_s] :tag (:div) the HTML tag to wrap the panel in.
    # @see http://getbootstrap.com/components/#panels-heading
    def panel(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        panel_string capture(&block), content_or_options_with_block || {}
      elsif content_or_options_with_block.is_a?(Hash) && options.nil?
        panel_string nil, content_or_options_with_block
      else
        panel_string content_or_options_with_block, options || {}
      end
    end

  private

    def panel_string(content = nil, options = {})
      content = prepend_optional_body_to content, options
      content = prepend_optional_heading_to content, options
      tag = options.fetch :tag, :div
      content_tag tag, content, class: panel_class(options[:context])
    end

    def panel_class(context = nil)
      context = case context.to_s
        when 'primary' then :primary
        when 'success' then :success
        when 'info' then :info
        when 'warning' then :warning
        when 'danger' then :danger
        else 'default'
      end
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
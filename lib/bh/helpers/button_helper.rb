require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include buttons.
  # @see http://getbootstrap.com/components/#buttons
  module ButtonHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *buttons*.
    #
    # The content of the button can either be passed as the first parameter (in
    # which case, the options are the second parameter), or as a block (in
    # which case, the options are the first paramter).
    # @example An button with plain-text content passed as the first parameter.
    #   <%= button 'Your profile was updated!', context: :info %>
    # @example A button with HTML content passed as a block.
    #   <%= button context: :info %>
    #     <%= glyphicon :star %> Star
    #   <% end %>
    #
    # @return [String] an HTML block tag for a button.
    # @param [String] content_or_options_with_block the content to display in
    #   the button.
    # @param [Hash] options the display options for the button.
    # @option options [#to_s] :context (:default) the contextual alternative to
    #   apply to the button depending on its importance. Can be :default,
    #   :primary, :success, :info, :warning, :danger or :link.
    # @option options [#to_s] :size the size of the button.
    # @option options [#to_s] :layout if set to :block, span the button for
    #   the full width of the parent.
    def button(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        button_string capture(&block), content_or_options_with_block || {}
      else
        button_string content_or_options_with_block, options || {}
      end
    end

  private

    def button_string(content = nil, options = {})
      append_class! options, btn_class(options)
      content_tag :button, content, options
    end

    def btn_class(options = {})
      valid_contexts = %w(primary success info warning danger link)
      context = context_for options.delete(:context), valid: valid_contexts
      "btn btn-#{context}"

      size = case options.delete(:size).to_s
        when 'lg', 'large' then 'btn-lg'
        when 'sm', 'small' then 'btn-sm'
        when 'xs', 'extra_small' then 'btn-xs'
      end

      layout = 'btn-block' if options.delete(:layout).to_s == 'block'

      ['btn', "btn-#{context}", size, layout].compact.join ' '
    end
  end
end
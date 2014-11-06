require 'bh/helpers/base_helper'

module Bh
  # Provides the `alert_box` helper.
  module AlertBoxHelper
    include BaseHelper
    # @see http://getbootstrap.com/components/#alerts
    # @return [String] an HTML block to display an alert box.
    # @overload alert_box(message, options = {})
    #   @param [#to_s] message the content to display in the alert box.
    #   @param [Hash] options the options for the alert box. Any option not
    #     listed below is used as an attribute for the alert’s <div>.
    #   @option options [Boolean] :dismissible (false) whether to display an
    #     '×' to the right of the box that can dismiss the alert.
    #   @option options [#to_s] :context (:info) the contextual alternative to
    #     apply to the alert. Can be `:danger`, `:info`, `:success` or
    #     `:warning`.
    #   @option options [#to_s] :priority if set to one of the priority levels
    #     of Rails flash messages, determines the context of the alert box.
    #     Can be :alert or :notice.
    #   @example Display a dismissible alert box with a plain-text message.
    #       alert_box 'User updated successfully', dismissible: true
    # @overload alert_box(options = {}, &content_block)
    #   @param [Hash] options the options for the alert box.
    #   @yieldreturn [#to_s] the content to display in the alert box.
    #   @example Display a dismissible alert box with an HTML message.
    #       alert_box 'User updated successfully' do
    #         content_tag :strong, "User updated successfully"
    #       end
    def alert_box(message_or_options_with_block = nil, options = nil, &block)
      if block_given?
        alert_string capture_alert(&block), message_or_options_with_block || {}
      else
        alert_string message_or_options_with_block, options || {}
      end
    end

  private

    def alert_string(message = nil, options = {})
      dismissible = options[:dismissible] || options[:priority]
      message = add_dismiss_button_to(message) if dismissible
      klass = alert_class options.fetch(:context, options[:priority])
      append_class! options, klass
      content_tag :div, message, options.merge(role: :alert)
    end

    def alert_class(context = nil)
      valid_contexts = %w(success info warning danger)
      context = context_for context, default: 'info', valid: valid_contexts
      "alert alert-#{context}"
    end

    def add_dismiss_button_to(message)
      options = {type: 'button', class: 'close', :'data-dismiss' => 'alert'}
      dismiss_button = content_tag :button, options do
        safe_join [
          content_tag(:span, '&times;'.html_safe, :'aria-hidden' => true),
          content_tag(:span, 'Close', class: 'sr-only'),
        ], ''
      end
      safe_join [dismiss_button, message], "\n"
    end

    # Captures the message passed as a block and sets a variable so that
    # every +link_to+ helper called inside the block gets the "alert-link"
    # class added, for links to look better.
    # @see http://getbootstrap.com/components/#alerts-links
    def capture_alert(&block)
      @alert_link = true
      capture(&block).tap{ @alert_link = false }
    end
  end
end
require 'bh/helpers/base_helper'

module Bh
  module AlertHelper
    include BaseHelper
    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *alert boxes*.
    # Alert boxes provide contextual feedback messages for typical user
    # actions with the handful of available and flexible alert messages.
    # @see http://getbootstrap.com/components/#alerts
    #
    # The message to display in the alert can either be passed as the first
    # parameter (in which case, the options are the second parameter), or as
    # a block (in which case, the options are the first parameter).
    # @example An alert with a plain-text message passed as the first parameter.
    #   alert 'User updated successfully', dismissible: true
    # @example An alert with an HTML message passed as a block.
    #   alert_box dismissible: true do
    #     content_tag :strong, "User updated successfully"
    #   end
    #
    # @return [String] an HTML block tag for an alert.
    # @param [String] message_or_options_with_block the message to display in
    #   the alert.
    # @param [Hash] options the options for the alert box.
    # @option options [Boolean] :dismissible (false) whether to display an '×'
    #   to the right of the alert than can be clicked to dismiss the alert.
    # @option options [#to_s] :context (:info) the contextual alternative to
    #   apply to the alert depending on its importance. Can be :success, :info,
    #   :warning  or :danger.
    # @option options [#to_s] :priority if the alert box is used to show a
    #   Rails flash message, the priority of the message. Can be :alert
    #   or :notice.
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
      content_tag :div, message, role: :alert, class: klass
    end

    def alert_class(context = nil)
      context = case context.to_s
        when 'success', 'notice' then :success
        when 'warning' then :warning
        when 'danger', 'alert' then :danger
        else 'info'
      end
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
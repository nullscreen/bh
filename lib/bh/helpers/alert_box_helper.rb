require 'bh/classes/alert_box'

module Bh
  # Provides the `alert_box` helper.
  module AlertBoxHelper
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
    def alert_box(*args, &block)
      alert_box = Bh::AlertBox.new(self, *args, &block)
      alert_box.extract! :context, :priority, :dismissible

      alert_box.append_class! :alert
      alert_box.append_class! alert_box.context_class
      alert_box.merge! role: :alert
      alert_box.prepend_html! alert_box.dismissible_button
      alert_box.render_tag :div
    end
  end
end
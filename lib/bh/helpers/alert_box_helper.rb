require 'bh/classes/alert_box'

module Bh
  module Helpers
    # Displays a Bootstrap-styled alert message.
    # @see http://getbootstrap.com/components/#alerts
    # @return [String] the HTML to display a Bootstrap-styled alert message.
    # @overload alert_box(content, options = {})
    #   @param [#to_s] content the content to display in the alert.
    #   @param [Hash] options the options for the alert box. Any option not
    #     listed below is passed as an HTML attribute to the alert’s `<div>`.
    #   @option options [Boolean] :dismissible (false) whether to display an
    #     '×' to the right of the box that can be clicked to dismiss the alert.
    #   @option options [#to_s] :context (:info) the contextual alternative to
    #     apply to the alert. Can be `:danger`, `:info`, `:success` or
    #     `:warning`.
    #   @option options [#to_s] :priority if set to one of the priority levels
    #     of Rails flash contents, determines the context of the alert box.
    #     Can be :alert or :notice.
    #   @example Display a dismissible alert box with a plain-text content.
    #       alert_box 'User updated successfully', dismissible: true
    # @overload alert_box(options = {}, &block)
    #   @param [Hash] options the options for the alert box (see above).
    #   @yieldreturn [#to_s] the content to display in the alert.
    #   @example Display a success alert box with an HTML content.
    #       alert_box context: :success do
    #         content_tag :strong, 'User updated successfully'
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
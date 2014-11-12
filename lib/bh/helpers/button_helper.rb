require 'bh/classes/button'

module Bh
  module Helpers
    # Displays a Bootstrap-styled button.
    # @see http://getbootstrap.com/css/#buttons
    # @return [String] the HTML to display a Bootstrap-styled button.
    # @overload button(caption, options = {})
    #   @param [#to_s] caption the caption to display in the button.
    #   @param [Hash] options the options for the button. Any option not
    #     listed below is passed as an HTML attribute to the `<button>` tag.
    #   @option options [#to_s] :context (:default) the contextual alternative
    #     to apply to the button. Can be `:danger`, `:info`, `:link`,
    #     `:primary`, `:success` or `:warning`.
    #   @option options [#to_s] :size the size of the button.
    #     Can be `:extra_small` (alias `:xs`), `:large` (alias `:lg`) or
    #     `:small` (alias `:sm`).
    #   @option options [#to_s] :layout if set to `:block`, span the button
    #     for the full width of the parent.
    #   @example Display a button styled as a link.
    #       button 'Click here', context: :link
    # @overload button(options = {}, &block)
    #   @param [Hash] options the options for the button (see above).
    #   @yieldreturn [#to_s] the caption to display in the button.
    #   @example Display a button with an HTML caption.
    #       button do
    #         content_tag :strong, 'Click here'
    #       end
    def button(*args, &block)
      button = Bh::Button.new(self, *args, &block)
      button.extract! :context, :size, :layout

      button.append_class! :btn
      button.append_class! button.context_class
      button.append_class! button.size_class
      button.append_class! button.layout_class
      button.render_tag :button
    end
  end
end
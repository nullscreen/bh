require 'bh/classes/button'

module Bh
  # Provides the `button` helper.
  module ButtonHelper
    # @see http://getbootstrap.com/css/#buttons
    # @return [String] an HTML block to display a button.
    # @overload button(caption, options = {})
    #   @param [#to_s] caption the caption to display in the button.
    #   @param [Hash] options the options for the button.
    #   @option options [#to_s] :context (:default) the contextual alternative
    #     to apply to the button. Can be `:danger`, `:info`, `:link`,
    #     `:primary`, `:success` or `:warning`.
    #   @option options [#to_s] :size the size of the button.
    #     Can be `:extra_small` (alias `:xs`), `:large` (alias `:lg`) or
    #     `:small` (alias `:sm`).
    #   @option options [#to_s] :layout if set to `:block`, span the button for
    #   the full width of the parent.
    #   @example Display a small warning button with a plain-text caption.
    #       button 'Delete', context: :warning, size: :small
    # @overload button(options = {}, &content_block)
    #   @param [Hash] options the options for the button.
    #   @yieldreturn [#to_s] the caption to display in the button.
    #   @example Display a button with an HTML message.
    #       button do
    #         content_tag :strong, "Click here"
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
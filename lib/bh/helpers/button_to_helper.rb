require 'bh/classes/button_to'
require 'bh/classes/navbar'
require 'bh/classes/stack'

module Bh
  module Helpers
    # Overrides `button_to` to display a Bootstrap-styled button.
    # Can only be used in Ruby frameworks that provide the `button_to` method.
    # Only overrides the original method if called with any of the `:context`,
    # `:size` or `:layout` option, otherwise calls the original method.
    # @see http://getbootstrap.com/css/#buttons
    # @see http://getbootstrap.com/components/#nav
    # @see http://getbootstrap.com/components/#navbar-buttons
    # @see http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-button_to
    # @see http://rubydoc.info/gems/padrino-helpers/Padrino/Helpers/FormHelpers#button_to-instance_method
    # @return [String] the HTML to display a Bootstrap-styled button.
    # @overload button_to(caption, url, options = {})
    #   @param [#to_s] caption the caption to display in the button.
    #   @param [#to_s] url the URL to submit to.
    #   @param [Hash] options the options for the button. Any option not
    #     listed below is passed to the original `button_to` method.
    #   @option options [#to_s] :context (:default) the contextual alternative
    #     to apply to the button. Can be `:danger`, `:info`, `:link`,
    #     `:primary`, `:success` or `:warning`.
    #   @option options [#to_s] :size the size of the button.
    #     Can be `:extra_small` (alias `:xs`), `:large` (alias `:lg`) or
    #     `:small` (alias `:sm`).
    #   @option options [#to_s] :layout if set to `:block`, span the button
    #     for the full width of the parent.
    #   @example Display a small button to submit to '/create_user'.
    #       button_to 'Create', '/create_user', size: :small
    # @overload button_to(url, options = {}, &block)
    #   @param [#to_s] url the URL to submit to (see above).
    #   @param [Hash] options the options for the button (see above).
    #   @yieldreturn [#to_s] the caption to display in the button.
    #   @example Display a danger button with HTML content to delete a user.
    #       button_to '/user_destroy', context: :danger do
    #         content_tag :strong, "Delete user"
    #       end
    def button_to(*args, &block)
      button_to = Bh::ButtonTo.new self, *args, &block

      if button_to.extract! :context, :size, :layout
        button_to.append_button_class! :btn
        button_to.append_button_class! button_to.context_class
        button_to.append_button_class! button_to.size_class
        button_to.append_button_class! button_to.layout_class
        button_to.append_form_class! 'navbar-form' if Bh::Stack.find(Bh::Navbar)
      end

      html = if block_given? && button_to.accepts_block?
        super button_to.url, button_to.attributes, &-> { button_to.content }
      else
        super button_to.content, button_to.url, button_to.attributes, &nil
      end

      if Bh::Stack.find(Bh::Nav)
        container = Bh::Base.new(self) { html }
        container.render_tag :li
      else
        html
      end
    end
  end
end
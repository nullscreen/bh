require 'bh/classes/modal'

module Bh
  module Helpers
    # Displays a Bootstrap-styled modal.
    # @see http://getbootstrap.com/javascript/#modals
    # @return [String] the HTML to display a Bootstrap-styled modal.
    # @overload modal(body, options = {})
    #   @param [#to_s] body the content to display as the modal body.
    #   @param [Hash] options the options for the modal. Any option not listed
    #     below is ignored, except for `:id` which is passed as an HTML
    #     attribute to the modal’s `<div>`.
    #   @option options [#to_s] :title ('Modal') the title of the modal.
    #   @option options [#to_s] :body the content to display as the modal body.
    #     Using this option is equivalent to passing the body as an argument.
    #   @option options [#to_s] :size the size of the modal. Can be `:large`
    #     (alias `:lg`) or `:small` (alias `:sm`).
    #   @option options [Hash] :button the options for the toggle button.
    #     * :caption (#to_s) ('Modal') the caption of the toggle button.
    #     * :context (#to_s) (:default) the contextual alternative to apply to
    #        the toggle button. Can be `:danger`, `:info`, `:link`, `:primary`,
    #       `:success` or `:warning`.
    #     * :size (#to_s) the size of the toggle button. Can be `:extra_small`
    #       (alias `:xs`), `:large` (alias `:lg`) or `:small` (alias `:sm`).
    #     * :layout (#to_s) if set to `:block`, span the button for the full
    #       width of the parent.
    #   @example Display a simple modal toggled by a blue button.
    #       modal 'You clicked me!', title: 'Click me', button: {context: :info}
    # @overload modal(options = {}, &block)
    #   @param [Hash] options the options for the modal (see above).
    #   @yieldreturn [#to_s] the content to display in the modal.
    #   @example Display a modal with HTML content.
    #       modal title: 'Click me' do
    #         content_tag :div, class: 'modal-body' do
    #           content_tag :em, 'You clicked me!'
    #         end
    #       end
    def modal(*args, &block)
      modal = Bh::Modal.new self, *args, &block
      modal.extract! :button, :size, :body, :title, :id

      modal.extract_from :button, [:context, :size, :layout, :caption]
      modal.append_class_to! :button, :btn
      modal.append_class_to! :button, modal.button_context_class
      modal.append_class_to! :button, modal.button_size_class
      modal.merge! button: {caption: modal.caption}

      modal.append_class_to! :div, :'modal-dialog'
      modal.append_class_to! :div, modal.dialog_size_class
      modal.merge! div: {title: modal.title, id: modal.id}

      modal.render_partial 'modal'
    end
  end
end
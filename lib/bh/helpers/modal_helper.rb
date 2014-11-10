require 'bh/classes/modal'

module Bh
  module Helpers
    # @see http://getbootstrap.com/javascript/#modals
    # @return [String] an HTML block to display a modal and a toggle button.
    # @example A small button to toggle a modal with a given body.
    #   modal button: {size: :xs}, body: 'Do what you want!'
    # @param [Hash] options the display options for the modal.
    # @option options [#to_s] :title ('Modal') the title of the modal.
    # @option options [#to_s] :body the body of modal (can also be passed as
    #   a block).
    # @option options [#to_s] :size the size of the modal. Can be `:large`
    #   (alias `:lg`) or `:small` (alias `:sm`).
    # @option options [Hash] :button the options for the toggle button.
    #   * :caption (#to_s) ('Modal') the caption of the toggle button.
    #   * :context (#to_s) (:default) the contextual alternative to apply to
    #      the toggle button. Can be `:danger`, `:info`, `:link`, `:primary`,
    #     `:success` or `:warning`.
    #   * :size (#to_s) the size of the toggle button. Can be `:extra_small`
    #     (alias `:xs`), `:large` (alias `:lg`) or `:small` (alias `:sm`).
    #   * :layout (#to_s) if set to `:block`, span the button for the full
    #     width of the parent.
    # @yieldreturn [#to_s] the content of the modal.
    def modal(*args, &block)
      modal = Bh::Modal.new self, *args, &block
      modal.extract! :button, :size, :body, :title, :id

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
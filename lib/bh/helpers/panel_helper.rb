require 'bh/classes/panel'
require 'bh/classes/panel_row'
require 'bh/classes/stack'

module Bh
  # Provides the `panel` helper.
  module PanelHelper
    # @see http://getbootstrap.com/components/#panels
    # @return [String] an HTML block to display a panel.
    # @overload panel(options = {})
    #   @example An informative panel with plain-text content.
    #   panel body: 'You accepted the Terms of service.', context: :success
    #   @param [Hash] options the display options for the panel.
    #   @option options [#to_s] :body the main text to include in the panel.
    #   @option options [#to_s] :heading the text to include above the body.
    #   @option options [#to_s] :title the text to include above the body,
    #     formatted for more impact than a simple heading.
    #   @option options [#to_s] :context (#to_s) (:default) the contextual
    #     alternative to apply to the panel heading and border. Can be
    #     `:danger`, `:info`, `:primary`, `:success` or `:warning`.
    #   @option options [#to_s] :tag (#to_s) (:div) the HTML tag to wrap the
    #     panel into.
    # @overload panel(options = {}, &content_block)
    #   @example An informative panel with HTML content.
    #   panel context: :success do
    #     content_tag :div, class: 'panel-body' do
    #       content_tag :strong, 'You accepted the Terms of service.'
    #   @yieldreturn [#to_s] the content of the panel.
    def panel(*args, &block)
      panel = Bh::Panel.new self, *args, &block
      panel.extract! :body, :context, :title, :heading, :tag

      panel.append_class! :panel
      panel.append_class! panel.context_class
      panel.merge_html! panel.body
      panel.prepend_html! panel.heading

      if panel_row = Bh::Stack.find(Bh::PanelRow)
        container = Bh::Base.new(self) { panel.content_tag panel.tag }
        container.append_class! panel_row.column_class
        container.render_tag :div
      else
        panel.render_tag panel.tag
      end
    end
  end
end
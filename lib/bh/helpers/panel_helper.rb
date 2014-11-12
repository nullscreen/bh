require 'bh/classes/panel'
require 'bh/classes/panel_row'
require 'bh/classes/stack'

module Bh
  module Helpers
    # Displays a Bootstrap-styled panel.
    # @see http://getbootstrap.com/components/#panels
    # @return [String] the HTML to display a Bootstrap-styled panel.
    # @overload panel(body, options = {})
    #   @param [#to_s] body the content to display as the panel body.
    #   @param [Hash] options the options for the panel. Any option not
    #     listed below is passed as an HTML attribute to the panel’s `<div>`.
    #   @option options [#to_s] :title the text to display as the panel title.
    #   @option options [#to_s] :heading the text to display as the panel 
    #     heading.
    #   @option options [#to_s] :body the text to display as the panel body.
    #     Using this option is equivalent to passing the body as an argument.
    #   @option options [#to_s] :context (#to_s) (:default) the contextual
    #     alternative to apply to the panel heading and border. Can be
    #     `:danger`, `:info`, `:primary`, `:success` or `:warning`.
    #   @option options [#to_s] :tag (#to_s) (:div) the HTML tag to wrap the
    #     panel into.
    #   @example Display an informative panel with plain-text content.
    #       panel 'You accepted the Terms of service.', context: :success
    # @overload panel(options = {}, &block)
    #   @param [Hash] options the options for the panel (see above).
    #   @yieldreturn [#to_s] the content to display in the panel.
    #   @example Display a panel with HTML content.
    #       panel title: 'Thanks' do
    #         content_tag :div, class: 'panel-body' do
    #           content_tag :em, 'ou accepted the Terms of service.'
    #         end
    #       end
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
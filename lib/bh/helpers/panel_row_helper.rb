require 'bh/classes/panel_row'

module Bh
  module Helpers
    # Wraps a set of Bootstrap-styled panels in a row.
    # @see http://getbootstrap.com/components/#panels
    # @see http://getbootstrap.com/css/#grid
    # @return [String] the HTML to display a row of Bootstrap-styled panels.
    # @param [Hash] options the options for the row. Any option not
    #   listed below is passed as an HTML attribute to the row’s `<div>`.
    # @option options [#to_s] :column_class the class to wrap each panel with.
    #   Useful to specify a grid size for the column such as 'col-sm-4' to
    #   indicate how many columns of the row each panel should occupy.
    # @yieldreturn [#to_s] the panels to display in a row.
    # @example Display a row of two panels with the same width.
    #   panel_row column_class: 'col-sm-6' do
    #     panel 'Panel #1', context: :success
    #     panel 'Panel #2', context: :info
    #   end
    def panel_row(options = {}, &block)
      panel_row = Bh::PanelRow.new self, options, &block
      panel_row.extract! :column_class

      panel_row.append_class! :row
      panel_row.render_tag :div
    end
  end
end
require 'bh/classes/panel_row'

module Bh
  # Provides the `panel_row` helper.
  module PanelRowHelper
    # @see http://getbootstrap.com/components/#panels
    # @see http://getbootstrap.com/css/#grid
    # @return [String] an HTML block to display a row of panels.
    # @example An row of 3 panels with the same width.
    #   panel_row column_class: 'col-sm-4' do
    #     panel body: 'Panel #1'
    #     panel body: 'Panel #2'
    #     panel body: 'Panel #3'
    # @param [Hash] options the display options for the row of panels.
    # @option options [#to_s] :column_class the class to wrap each panel with.
    #   Useful to specify a grid size for the column such as 'col-sm-4' to
    #   indicate how many columns of the row each panel should occupy.
    # @yieldreturn [#to_s] the panels to display in a row.
    def panel_row(*args, &block)
      panel_row = Bh::PanelRow.new self, *args, &block
      panel_row.extract! :column_class

      panel_row.append_class! :row
      panel_row.render_tag :div
    end
  end
end
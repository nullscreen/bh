require 'bh/helpers/panel_helper'

module Bh
  # Provides methods to include multiple panels in a row.
  # @see http://getbootstrap.com/css/#grid
  # @see http://getbootstrap.com/components/#panels
  module PanelRowHelper
    include PanelHelper # for panel

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display a *row*, passing column options to each panel in
    # the row.
    #
    # @return [String] an HTML block tag for a row of panels.
    # @param [Hash] options the display options for the row of panels.
    # @option options [#to_s] :column_class the class to apply to the column
    #   <div> that wraps every panel in the row. Useful to specify a grid size
    #   for the column such as 'col-sm-4' to indicate how many columns of the
    #   row each panel should occupy.
    # @see http://getbootstrap.com/css/#grid
    # @see http://getbootstrap.com/components/#panels
    def panel_row(options = {}, &block)
      content_tag :div, class: 'row' do
        capture_panel_row(options, &block) if block_given?
      end
    end

  private

    # Overrides PanelHelper +panel+ to be able to add a column <div> around
    # each panel in a row, to make it fit inside the panel row.
    def panel(*args, &block)
      panel = super *args, &block
      if @panel_column_class
        content_tag :div, panel, class: @panel_column_class
      else
        panel
      end
    end

    def capture_panel_row(options = {}, &block)
      @panel_column_class = options[:column_class]
      capture(&block).tap{ @panel_column_class = nil }
    end
  end
end
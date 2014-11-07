require 'bh/classes/base'

module Bh
  module Classes
    class PanelRow < Base
      # @return [#to_s] the grid-related class to assign to each panel
      #   nested in this panel row.
      def column_class
        @options[:column_class]
      end
    end
  end
end
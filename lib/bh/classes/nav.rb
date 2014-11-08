require 'bh/classes/base'

module Bh
  module Classes
    class Nav < Base
      # @return [#to_s] the style-related class to assign to the nav.
      def style_class
        styles[@options[:as]]
      end

      # @return [#to_s] the layout-related class to assign to the nav.
      def layout_class
        layouts[@options[:layout]]
      end

      # @return [Hash<Symbol, String>] the classes that Bootstrap requires to
      #   append to navs for each possible style.
      def styles
        HashWithIndifferentAccess.new(:'nav-tabs').tap do |klass|
          klass[:pills] = :'nav-pills'
        end
      end

      # @return [Hash<Symbol, String>] the classes that Bootstrap requires to
      #   append to buttons for each possible layout.
      def layouts
        HashWithIndifferentAccess.new.tap do |klass|
          klass[:justified] = :'nav-justified'
          klass[:stacked]   = :'nav-stacked'
        end
      end
    end
  end
end
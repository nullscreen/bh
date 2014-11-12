require 'bh/classes/button'

module Bh
  module Classes
    class Dropdown < Button
      # @return [#to_s] the group-related class to assign to the dropdown.
      def groupable_class
        Dropdown.groupables[@options[:groupable]]
      end

      # @return [#to_s] the direction-related class to assign to the dropdown.
      def direction_class
        Dropdown.directions[@options[:direction]]
      end

      # @return [#to_s] the align-related class to assign to the dropdown.
      def align_class
        Dropdown.aligns[@options[:align]]
      end

      def id
        @options.fetch :id, "dropdown-#{rand 10**10}"
      end

      def partial
        @options[:split] ? 'dropdown_split' : 'dropdown'
      end

    private

      # @return [Hash<Symbol, String>] the class that Bootstrap requires to
      #   append to a dropdown to display it as inline or block.
      def self.groupables
        HashWithIndifferentAccess.new(:'btn-group').tap do |klass|
          klass[false] = :dropdown
        end
      end

      # @return [Hash<Symbol, String>] the class that Bootstrap requires to
      #   append to a dropdown to show a drop-"up" or -"down".
      def self.directions
        HashWithIndifferentAccess.new.tap do |klass|
          klass[:up] = :dropup
        end
      end

      # @return [Hash<Symbol, String>] the class that Bootstrap requires to
      #   append to a dropdown to left- or right- align to the toggle button.
      def self.aligns
        HashWithIndifferentAccess.new.tap do |klass|
          klass[:right] = :'dropdown-menu-right'
        end
      end
    end
  end
end
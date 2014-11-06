module Bh
  module Classes
    class Stack
      @@stack = []

      def self.unshift(item)
        @@stack.unshift item
      end

      def self.shift
        @@stack.shift
      end

      def self.find(helper_class)
        @@stack.find{|helper| helper.is_a? helper_class}
      end
    end
  end
end
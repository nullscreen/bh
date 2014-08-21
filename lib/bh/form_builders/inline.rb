require 'bh/form_builders/basic'

module Bh
  module FormBuilders
    class Inline < Basic

    private

      def label_options
        {class: 'sr-only'}
      end
    end
  end
end
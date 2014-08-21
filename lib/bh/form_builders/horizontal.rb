require 'bh/form_builders/basic'

module Bh
  module FormBuilders
    class Horizontal < Basic

    private

      def label_options
        {class: 'col-sm-3 control-label'}
      end

      def field_container(offset = false, &block)
        klass = [('col-sm-offset-3' if offset), 'col-sm-9'].compact.join ' '
        content_tag :div, class: klass, &block
      end

      def submit_container(&block)
        right_aligned_container(&block)
      end

      def check_box_container(inline_label, &block)
        inline_label ? right_aligned_container(&block) : yield
      end

      def radio_button_container(&block)
        right_aligned_container(&block)
      end

      def right_aligned_container(&block)
        content_tag :div, field_container(true, &block), class: 'form-group'
      end

      def legend_container(&block)
        content_tag :div, class: 'col-sm-12', &block
      end
    end
  end
end
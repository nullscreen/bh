require 'bh/form_builders/basic'

module Bh
  module FormBuilders
    class Horizontal < Basic

    private

      def label_options
        {class: 'col-sm-3 control-label'}
      end

      def field_container(&block)
        content_tag :div, class: 'col-sm-9', &block
      end

      def submit_container(&block)
        content_tag :div, class: 'form-group' do
          content_tag :div, class: 'col-sm-offset-3 col-sm-9', &block
        end
      end
      
      def legend_container(&block)
        content_tag :div, class: 'col-sm-12', &block
      end
    end
  end
end
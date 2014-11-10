require 'bh/classes/base'

module Bh
  module Classes
    class Vertical < Base
      def toggle_button(navbar_id, options = {})
        options[:'class']       = :'navbar-toggle'
        options[:'data-target'] = :"##{navbar_id}"
        options[:'data-toggle'] = :'collapse'
        options[:'type']        = :'button'
        @app.content_tag :button, options do
          safe_join [toggle_text, toggle_bar, toggle_bar, toggle_bar]
        end
      end

    private

      def toggle_text
        @app.content_tag :span, 'Toggle navigation', class: :'sr-only'
      end

      def toggle_bar
        @app.content_tag :span, nil, class: :'icon-bar'
      end
    end
  end
end
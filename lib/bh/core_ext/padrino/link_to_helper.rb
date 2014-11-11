require 'bh/classes/link_to'

require 'bh/classes/alert_box'
require 'bh/classes/dropdown'
require 'bh/classes/nav'
require 'bh/classes/stack'
require 'bh/classes/vertical'

module Bh
  module Padrino
    module Helpers
      # Overrides ActionView +link_to+ to be able to add the 'alert-link' class
      # to the link in case the link is inside of an alert.
      # @see http://getbootstrap.com/components/#alerts-links
      # Overrides ActionView +link_to+ to be able to surround the link in a
      # '<li>' item in case the link is inside of a nav.
      # Overrides ActionView +link_to+ to be able to add the 'navbar-brand'
      # class to the link in case the link is inside of an alert.
      def link_to(*args, &block)
        link_to = Bh::LinkTo.new self, *args, &block
        link_to.append_class! :'alert-link' if Bh::Stack.find(Bh::AlertBox)
        link_to.append_class! :'navbar-brand' if Bh::Stack.find(Bh::Vertical)
        link_to.merge! role: :menuitem if Bh::Stack.find(Bh::Dropdown)
        link_to.merge! tabindex: -1 if Bh::Stack.find(Bh::Dropdown)
        html = super link_to.content, link_to.url, link_to.attributes, &nil

        if Bh::Stack.find(Bh::Dropdown)
          container = Bh::Base.new(self) { html }
          container.merge! role: :presentation
          container.render_tag :li
        elsif Bh::Stack.find(Bh::Nav)
          container = Bh::Base.new(self) { html }
          container.append_class! :active if current_page?(link_to.url)
          container.render_tag :li
        else
          html
        end
      end

      # Provides the equivalent of the current_page? method from Rails to
      # Padrino (and therefore Middleman) that do not have one.
      # @see https://github.com/padrino/padrino-framework/issues/235
      def current_page?(options)
        current_request = defined?(req) ? req : request
        current_request.path_info == url_for(*options)
      end
    end
  end
end
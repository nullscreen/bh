require 'action_view'

module Bh
  module UrlHelper
    include ActionView::Helpers::UrlHelper # for link_to

    # Overrides ActionView +link_to+ to be able to add the 'alert_link' class
    # to the link in case the link is inside of an alert.
    # @see http://getbootstrap.com/components/#alerts-links
    def link_to(*args, &block)
      args = add_alert_class_to_link!(*args, &block) if @alert_link
      super *args, &block
    end

  private

    def add_alert_class_to_link!(*args, &block)
      html_options = (block_given? ? args[1] : args[2]) || {}
      klass = html_options[:class]
      html_options[:class] = [klass, 'alert-link'].compact.join ' '
      block_given? ? args[1] = html_options : args[2] = html_options
      args
    end
  end
end
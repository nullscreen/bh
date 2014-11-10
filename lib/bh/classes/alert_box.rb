require 'bh/classes/base'

module Bh
  module Classes
    class AlertBox < Base
      # @return [#to_s] the content-related class to assign to the alert box.
      def context_class
        AlertBox.contexts[@options.fetch :context, @options[:priority]]
      end

      # @return [#to_s] the HTML to show a dismissible button for the alert box.
      def dismissible_button
        if @options[:dismissible] || @options[:priority]
          path = '../../views/bh/_alert_dismiss_button.html'
          File.read File.expand_path(path, __FILE__)
        end
      end

    private

      # @return [Hash<Symbol, String>] the class that Bootstrap requires to
      #   append to an alert box based on its context.
      def self.contexts
        HashWithIndifferentAccess.new(:'alert-info').tap do |klass|
          klass[:alert]   = :'alert-danger'
          klass[:danger]  = :'alert-danger'
          klass[:info]    = :'alert-info'
          klass[:notice]  = :'alert-success'
          klass[:success] = :'alert-success'
          klass[:warning] = :'alert-warning'
        end
      end
    end
  end
end
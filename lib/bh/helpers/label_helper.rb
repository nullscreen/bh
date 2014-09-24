require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include vector icons from different libraries.
  # @see http://getbootstrap.com/components/#glyphicons
  # @see http://fortawesome.github.io/Font-Awesome/examples/#bootstrap
  module LabelHelper
    include BaseHelper

    # Returns an HTML span tag to display a Bootstrap label.
    # @see http://getbootstrap.com/components/#labels
    #
    # @return [String] an HTML span tag for a label.
    # @param [String] text The text to display in the label.
    # @param [Hash] options the options for the label.
    # @option options [#to_s] :context (:default) the contextual alternative to
    #   apply to the label depending on its importance. Can be :primary, :success, 
    #   :info, :warning, or :danger.
    #
    # @example Display a label with the default styling.
    #   bh_label 'hello'
    #
    # @example Display a label style with the "primary" appearance.
    #   bh_label 'hello', context: :primary
    def bh_label(text, options = {})
      append_class! options, 'label'
      context = context_for options.fetch(:context, nil), default: 'default', valid: %w(primary success info warning danger)
      append_class! options, "label-#{context}"
      content_tag :span, text, class: options[:class]
    end

  end
end
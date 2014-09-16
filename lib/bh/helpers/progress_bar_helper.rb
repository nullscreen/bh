require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include progress bars.
  # @see http://getbootstrap.com/components/#progress
  module ProgressBarHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation
    # on how to display *progress bars*.
    # @param [Hash, Array<Hash>] options the display options for the progress
    #   bar(s). When options is an Array, a group of stacked progress bars
    #   is displayed, with the options specified in each item of the array.
    # @option options [Boolean, #to_s] :label (false) the label to display
    #   on top of the progress bar. If set to false, the label is hidden. If
    #   set to true, the label is generated from the percentage value. Any
    #   other provided value is used directly as the label.
    # @option options [Boolean] :striped (false) whether to display a striped
    #   version of the progress bar (rather than solid color).
    # @option options [Boolean] :animated (false) whether to display an
    #   animated version of the progress bar (rather than solid color).
    # @option options [#to_s] :context (:default) the contextual alternative to
    #   apply to the progress bar depending on its importance. Can be
    #   `:success`, `:info`, `:warning` or `:danger`.
    def progress_bar(options = {})
      content_tag :div, class: :progress do
        safe_join Array.wrap(options).map{|bar| progress_bar_string bar}, "\n"
      end
    end

  private

    def progress_bar_string(options = {})
      percentage = options.fetch :percentage, 0

      attributes = {}.tap do |attrs|
        attrs[:class] = progress_bar_class(options)
        attrs[:role] = 'progressbar'
        attrs[:style] = "width: #{percentage}%"
        attrs['aria-valuenow'] = percentage
        attrs['aria-valuemin'] = 0
        attrs['aria-valuemax'] = 100
      end

      content_tag :div, progress_bar_label(percentage, options), attributes
    end

    def progress_bar_label(percentage, options = {})
      text = "#{percentage}%#{" (#{options[:context]})" if options[:context]}"
      case options.fetch(:label, false)
        when true then text
        when false then content_tag(:span, text, class: 'sr-only')
        else options[:label]
      end
    end

    def progress_bar_class(options = {})
      valid_contexts = %w(success info warning danger)
      context = context_for options[:context], valid: valid_contexts
      context = context.in?(valid_contexts) ? "progress-bar-#{context}" : nil
      striped = 'progress-bar-striped' if options[:striped]
      animated = 'progress-bar-striped active' if options[:animated]
      ['progress-bar', context, striped, animated].compact.join ' '
    end
  end
end
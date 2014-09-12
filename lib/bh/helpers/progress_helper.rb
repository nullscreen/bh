require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include progress bars.
  # @see http://getbootstrap.com/components/#progress
  module ProgressHelper
    include BaseHelper

    # Returns an HTML span tag that follows the Bootstrap documentation
    # on how to display *progress bars*.
    #
    # @return [String] an HTML block tag for a progress bar.
    # @param [#to_s] the value for the progress bar to display
    # @example Display a progress bar with a value of 42 (with default percentage for 1..100)
    #   progress 42
    # @example Display a progress bar with a value of 42, min & max values, label and sr_label
    #   progress 42, min: 2, max: 73, label: '31 USD', sr_label: '(until goal is reached)'
    def progress(value, options = {})
      options = {
        min: 0,
        max: 100,
        role: 'progressbar'
      }.merge(options)

      append_class! options, class_for_context('progress-bar', options.delete(:context))

      append_class! options, 'progress-bar-striped' unless options.delete(:striped).blank?
      append_class! options, 'active' unless options.delete(:active).blank?

      options['aria-valuenow'] = value
      options[:style]          = "width: #{options['aria-valuenow']}%;"
      options['aria-valuemin'] = options.delete(:min)
      options['aria-valuemax'] = options.delete(:max)

      progress_string options
    end

  private

    def progress_string(options)
      content_tag :div, progress_bar(options), class: 'progress'
    end

    def progress_bar(options)
      content_tag :div, options do
        inner   = ''.html_safe
        inner  += content_tag :span, options[:label] unless options[:label].blank?
        inner  += content_tag :span, " #{options[:sr_label]}", class: 'sr-only' unless options[:sr_label].blank?
        inner
      end
    end
  end
end

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
    # @param either an hash or an array of hashes
    # @example Display a progress bar with a value of 42 (with default percentage for 1..100)
    #   progress value: 42
    # @example Display a progress bar with a value of 42, min & max values, label and sr_label
    #   progress value: 42, min: 2, max: 73, label: '31 USD', sr_label: '(until goal is reached)'
    # @example Display a progress bar with a value of 42 (with default percentage for 1..100)
    #   progress [{value: 42}, {value: 73}]
    def progress(options_or_options_array)
      bars = options_or_options_array.is_a?(Hash) ? [set_options!(options_or_options_array)] : options_or_options_array.map { |bar| set_options!(bar) }
      progress_string(bars)
    end

  private

    def progress_string(progress_bars)
      bars  = ''.html_safe
      content_tag :div, class: 'progress' do
        progress_bars.each { |bar| bars << progress_bar(bar) }
        bars
      end
    end

    def progress_bar(options)
      content_tag :div, options do
        inner   = ''.html_safe
        inner  += content_tag :span, options[:label] unless options[:label].blank?
        inner  += content_tag :span, " #{options[:sr_label]}", class: 'sr-only' unless options[:sr_label].blank?
        inner
      end
    end

    def set_options!(options)
      options = {
        min: 0,
        max: 100,
        role: 'progressbar'
      }.merge(options)

      append_class! options, class_for_context('progress-bar', options.delete(:context))

      append_class! options, 'progress-bar-striped' unless options.delete(:striped).blank?
      append_class! options, 'active' unless options.delete(:active).blank?

      raise ArgumentError, 'value must be set in argument hash' if options[:value].blank?
      options['aria-valuenow'] = options.delete(:value)
      options[:style]          = "width: #{options['aria-valuenow']}%;"
      options['aria-valuemin'] = options.delete(:min)
      options['aria-valuemax'] = options.delete(:max)
      options
    end
  end
end

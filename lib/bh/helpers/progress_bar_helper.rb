require 'bh/classes/progress_bar'

module Bh
  module Helpers
    # Displays one or more Bootstrap-styled progress bars.
    # @see http://getbootstrap.com/components/#progress
    # @return [String] the HTML to display Bootstrap-styled progress bars.
    # @overload progress_bar(bar_options = {}, container_options = {})
    #   @param [Hash] bar_options the options to display a single progress bar.
    #     Any option not listed below is passed as an HTML attribute to the
    #     bar’s `<div>`.
    #   @option bar_options [Boolean, #to_s] :label (false) the label to display
    #     on top of the progress bar. If set to false, the label is hidden. If
    #     set to true, the label is generated from the percentage value. Any
    #     other provided value is used directly as the label.
    #   @option bar_options [Boolean] :striped (false) whether to display a
    #     striped version of the progress bar (rather than solid color).
    #   @option bar_options [Boolean] :animated (false) whether to display an
    #     animated version of the progress bar (rather than solid color).
    #   @option bar_options [#to_s] :context (:default) the contextual
    #     alternative to apply to the progress bar. Can be `:success`, `:info`,
    #     `:warning` or `:danger`.
    #   @param [Hash] container_options the options to pass as HTML attributes
    #     to the container’s `<div>`.
    #   @example Display a 30% warning progress bar.
    #       progress_bar percentage: 30, context: :warning
    # @overload progress_bar(stacked_bars_options = [], container_options = {})
    #   @param [Hash] stacked_bars_options an array of bar_options (see above).
    #     When an array is provided, a group of stacked progress bars is 
    #     displayed, each one matching the corresponding bar options.
    #   @param [Hash] container_options the options to pass as HTML attributes
    #     to the container’s `<div>`.
    #   @example Display two stacked progress bars.
    #       progress_bar [{percentage: 30, context: :warning}, {percentage: 20}]
    def progress_bar(args = nil, container_options = {})
      progress_bars = Array.wrap(args).map do |options|
        progress_bar = Bh::ProgressBar.new self, nil, options
        progress_bar.extract! :percentage, :context, :striped, :animated, :label

        progress_bar.merge! progress_bar.aria_values
        progress_bar.append_class! :'progress-bar'
        progress_bar.append_class! progress_bar.context_class
        progress_bar.append_class! progress_bar.striped_class
        progress_bar.append_class! progress_bar.animated_class
        progress_bar.merge! progress_bar.values
        progress_bar.prepend_html! progress_bar.label
        progress_bar
      end

      container = Bh::Base.new self, progress_bars, container_options
      container.append_class! :progress
      container.render_tag :div
    end
  end
end
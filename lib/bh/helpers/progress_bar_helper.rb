require 'bh/classes/progress_bar'

module Bh
  module Helpers
    # @see http://getbootstrap.com/components/#progress
    # @return [String] an HTML block to display a progress bar.
    # @example A 50%-filled, striped progress bar.
    #   progress_bar percentage: 50, striped: true
    # @overload progress_bar(options = {})
    #   @param [Hash] options the options for the progress bar.
    #   @option options [Boolean, #to_s] :label (false) the label to display
    #     on top of the progress bar. If set to false, the label is hidden. If
    #     set to true, the label is generated from the percentage value. Any
    #     other provided value is used directly as the label.
    #   @option options [Boolean] :striped (false) whether to display a striped
    #     version of the progress bar (rather than solid color).
    #   @option options [Boolean] :animated (false) whether to display an
    #     animated version of the progress bar (rather than solid color).
    #   @option options [#to_s] :context (:default) the contextual alternative
    #     to apply to the progress bar. Can be `:success`, `:info`, `:warning`
    #     or `:danger`.
    # @overload progress_bar(array_of_options = [])
    #   @param [Array<Hash>] array_of_options the set of options for each
    #     progress bar. When an array is provided, a group of stacked progress
    #     bar is displayed, each one with the corresponding options.
    def progress_bar(args = nil, options = {})
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

      container = Bh::Base.new self, progress_bars, options
      container.append_class! :progress
      container.render_tag :div
    end
  end
end
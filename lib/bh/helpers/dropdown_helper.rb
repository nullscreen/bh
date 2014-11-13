require 'bh/classes/dropdown'

module Bh
  module Helpers
    # @see http://getbootstrap.com/components/#dropdowns
    # @see http://getbootstrap.com/components/#btn-dropdowns
    # @return [String] an HTML block to display a dropdown.
    # @example A right-aligned dropdown with a links.
    #   dropdown 'Menu', align: :right do
    #     content_tag :li, link_to('Home', '/')
    #   end
    # @param [#to_s] caption the caption for the dropdown button.
    # @param [Hash] options the display options for the dropdown.
    # @option options [Boolean] :groupable (true) if true, uses the "btn-group"
    #   class rather than then "dropdown" class, so that multiple dropdown
    #   buttons can be aligned in the same row (as a group of buttons).
    # @option options [Boolean] :split (false) if true, creates a split button
    #   that only toggles the dropdown when clicked on the rightmost part.
    # @option options [#to_s] :direction if set to :up, the dropdown appears
    #   above the button, rather than below.
    # @option options [#to_s] :layout if set to `:block`, span the dropdown
    #   button for the full width of the parent. Note that :groupable takes
    #   precedence, so it must be set to `false` to display a full-width button.
    # @option options [#to_s] :align if set to :right, the dropdown is aligned
    #   to the right-end of the button, rather than to the left-end.
    # @option options [#to_s] :context (:default) the context for the button,
    #   which determines its color.
    # @option options [#to_s] :size the size of the button.
    # @yieldreturn [#to_s] the content of the dropdown.
    def dropdown(caption, options = {}, &block)
      dropdown = Bh::Dropdown.new self, nil, options, &block
      dropdown.extract! :id, :groupable, :direction, :align, :split, :context,
                        :size, :layout, :button

      dropdown.extract_from :button, [:context, :size, :layout]
      dropdown.merge! button: {caption: caption, id: dropdown.id}
      dropdown.append_class_to! :button, :btn
      dropdown.append_class_to! :button, dropdown.context_class
      dropdown.append_class_to! :button, dropdown.size_class
      dropdown.append_class_to! :button, dropdown.layout_class
      dropdown.append_class_to! :div, dropdown.groupable_class
      dropdown.append_class_to! :div, dropdown.direction_class
      dropdown.append_class_to! :ul, :'dropdown-menu'
      dropdown.append_class_to! :ul, dropdown.align_class

      dropdown.render_partial dropdown.partial
    end
  end
end
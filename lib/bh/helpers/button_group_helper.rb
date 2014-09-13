require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include button groups and buttons
  # @see http://getbootstrap.com/components/#btn-groups
  module ButtonGroupHelper
    include BaseHelper

    # Returns an HTML block tag that follows the buttons documentation
    # @return [String] an HTML block tag for button and button groups.
    # @example Button group with justified layout, buttons and have the btn-group variation dropup
    #   button_group layout: :justified, direction: :up do
    #     button 'Default'
    #     button 'Success', context: :success
    #     button 'Large info', size: :large, context: :info
    #   end
    # @example Button group with vertical layout and nested dropdown button
    #   button_group layout: :vertical do
    #     button 'Default'
    #     button 'Dropdown', dropdown: true, split: true do
    #       content_tag :ul, class: 'dropdown-menu' do 
    #         # ...
    #       end
    #     end
    #   end
    # @example Button group toolbar with buttons
    #   button_group layout: :toolbar do
    #     button_group do
    #       button 'First group'
    #       button 'First group'
    #     end
    #     button_group do
    #       button 'Second group'
    #       button 'Second group'
    #     end
    #   end
    def button_group(options = {}, &block)
      set_group_options!(options)
      content_tag :div, capture(&block), options
    end

     # Returns an HTML block tag that follows the buttons documentation
    # @return [String] an HTML block tag for a button.
    # @example Button with name
    #   button 'Default'
    # @example Button with name and context
    #   button 'Success', context: :success
    # @example Button with name, context and size
    #   button 'Large info', size: :large, context: :info
    # @example Button with splitted dropdown
    #   button 'Dropdown', split: true do
    #     content_tag :ul, class: 'dropdown-menu' do 
    #       # ...
    #     end
    #   end
    def button(name, options = {}, &block)
      set_button_options!(options)
      button_string name, options, &block
    end

  private

    def button_string(name, options, &block)
      split          = options.delete(:split)
      button_content = nil
      button_string  = content_tag :button, name, options
      caret_string   = content_tag :span, nil, class: 'caret'

      if block_given?
        caret_options = options.dup
        if split
          set_dropdown_trigger_options!(caret_options)
          caret_string  = content_tag :button, caret_string, caret_options
          button_string = safe_join [content_tag(:button, name, options), caret_string]
        else
          set_dropdown_trigger_options!(options)
          button_string = content_tag :button, safe_join([name, ' ', caret_string]), options # string with space if inline-block margin fix
        end
      end

      button_content  = [button_string]
      button_content << capture(&block) if block_given?
      safe_join button_content.compact
    end

    def set_group_options!(options)
      append_class! options, button_group_base_class(options)
      append_class! options, class_for_size('btn-group', options.delete(:size))
      append_class! options, 'dropup' if options.delete(:dropup)
      options
    end

    def set_button_options!(options)
      append_class! options, class_for_context('btn', options.delete(:context))
      append_class! options, class_for_size('btn', options.delete(:size))
    end

    def set_dropdown_trigger_options!(options)
      append_class! options, 'dropdown-toggle'
      options.merge!({ data: { toggle: :dropdown } })
    end

    def button_group_base_class(options)
      layout = case options.delete(:layout).to_s
      when 'vertical'  then 'btn-group-vertical'
      when 'justified' then 'btn-group btn-group-justified'
      else 'btn-group'
      end
      layout = 'btn-toolbar' if options.delete(:toolbar)
      layout
    end
  end
end
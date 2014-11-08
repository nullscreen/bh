require 'bh/helpers/base_helper'

module Bh
  # Provides the `horizontal` helper.
  module HorizontalHelper
    include BaseHelper

    def horizontal(content_or_options_with_block = nil, options = nil, &block)
      if block_given?
        horizontal_string (content_or_options_with_block || {}), &block
      else
        horizontal_string (options || {}), &Proc.new { content_or_options_with_block }
      end
    end

  private

    def horizontal_string(options = {}, &block)
      append_class! options, 'collapse navbar-collapse'
      options[:id] = navbar_id
      content_tag :div, options, &block
    end
  end
end
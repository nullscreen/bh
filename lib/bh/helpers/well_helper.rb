require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include well
  # @see http://getbootstrap.com/components/#wells
  module WellHelper
    include BaseHelper

    # Returns an HTML block tag that follows the Bootstrap documentation for a well
    # @return [String] an HTML block tag for a well.
    # @example A well with HTML content passed as a block.
    #   well do
    #     content_tag :strong, "Your profile was updated!"
    #   end
    # @example A well with HTML content passed as a block with size option.
    #   well(size: :large) do
    #     content_tag :strong, "Your profile was updated!"
    #   end
    def well(options = {}, &block)
      prefix = :well
      append_class! options, prefix
      append_class! options, class_for_size(prefix, options.delete(:size))
      content_tag :div, capture(&block), options
    end
  end
end
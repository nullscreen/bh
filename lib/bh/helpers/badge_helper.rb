require 'bh/helpers/base_helper'

module Bh
  # Provides methods to include lables and badges.
  # @see http://getbootstrap.com/components/#labels
  # @see http://getbootstrap.com/components/#badges
  module BadgeHelper
    include BaseHelper

    # Returns an HTML span tag that follows the Bootstrap documentation
    # on how to display *labels* and *badges*.
    #
    # @return [String] an HTML block tag for an icon.
    # @param [#to_s] the content for the badge or label to display
    # @example Display 42 in a badge
    #   badge 42
    # @example Display 42 in a label
    #   badge 42, as: :label
    def badge(content, options = {}, &block)
      raise ArgumentError, 'content can *not* be a hash' if content.is_a?(Hash)
      append_class! options, class_for_context(extract_badge_type!(options), options.delete(:context))
      content_tag :span, content, options
    end

  private

    def extract_badge_type!(options)
      as_option  = options.delete(:as)
      badge_type = case as_option.to_s
        when 'label'      then :label
        when 'badge', ''  then :badge
        else raise ArgumentError, "Unknown option for as: #{as_option}"
      end
      badge_type
    end
  end
end

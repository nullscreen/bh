require 'action_view'

module Bh
  module Rails
    # @api private
    module BaseHelper
      include ActionView::Helpers::TagHelper # for content_tag
      include ActionView::Context # for capture
      include ActionView::Helpers::OutputSafetyHelper # for safe_join
      include ActionView::Helpers::RenderingHelper # for render
      include ActionView::Helpers::UrlHelper # for link_to

    private

      def append_class!(hash, new_class, attribute = :class)
        existing_class = hash[attribute]
        hash[attribute] = [existing_class, new_class].compact.join ' '
      end
    end
  end
end
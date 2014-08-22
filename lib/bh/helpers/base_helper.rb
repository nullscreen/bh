require 'action_view'

module Bh
  module BaseHelper
    include ActionView::Helpers::TagHelper # for content_tag
    include ActionView::Context # for capture
    include ActionView::Helpers::OutputSafetyHelper # for safe_join
    include ActionView::Helpers::RenderingHelper # for render

  private

    def append_class!(hash, new_class)
      existing_class = hash[:class]
      hash[:class] = [existing_class, new_class].compact.join ' '
    end
  end
end
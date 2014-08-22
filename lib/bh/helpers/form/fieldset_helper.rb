require 'bh/helpers/panel_helper'

module Bh
  module Form
    module FieldsetHelper
      include BaseHelper
      include PanelHelper # for panel

      def fieldset(title = nil, &block)
        options = {tag: :fieldset, body: @template.capture(&block)}
        options[:heading] = title if title.present? && !inline_form?
        panel options
      end
    end
  end
end
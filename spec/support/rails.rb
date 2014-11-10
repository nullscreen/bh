require 'action_dispatch'
require 'active_support'
require 'action_view'

require 'bh/core_ext/rails/button_to_helper'
require 'bh/core_ext/rails/link_to_helper'

# A view that behaves like a Rails/ActionView view
class RailsView
  include ActionView::Context # for capture
  include ActionView::Helpers::RenderingHelper # for render
  include ActionView::Helpers::TagHelper # for content_tag
  include ActionView::Helpers::UrlHelper # for link_to

  include Bh::Helpers
  include Bh::Rails::Helpers

  def initialize
  end

  def request
    ActionDispatch::Request.new 'REQUEST_METHOD' => 'GET'
  end

  def protect_against_forgery?
    false
  end
end
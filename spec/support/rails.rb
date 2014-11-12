require 'action_dispatch'
require 'action_view'

# A view that behaves like a Rails/ActionView view
class RailsView
  include ActionView::Context # for capture
  include ActionView::Helpers::RenderingHelper # for render
  include ActionView::Helpers::TagHelper # for content_tag
  include ActionView::Helpers::UrlHelper # for link_to

  include Bh::Helpers

  def initialize
  end

  def request
    ActionDispatch::Request.new 'REQUEST_METHOD' => 'GET'
  end

  def protect_against_forgery?
    false
  end

  def test_button_to_with_block
    true
  end
end
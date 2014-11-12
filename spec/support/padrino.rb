require 'tilt'
require 'padrino-helpers'
require 'padrino-routing'

# A view that behaves like a Padrino view
class PadrinoView
  include Padrino::Helpers::OutputHelpers # for capture
  include Padrino::Helpers::TagHelpers # for content_tag
  include Padrino::Helpers::AssetTagHelpers # for link_to
  include Padrino::Helpers::FormHelpers # for button_to
  include Padrino::Routing::Helpers # for url_for
  include Bh::Helpers

  def self.app_name
    'test'
  end

  def self.named_paths
    {[:test, "/"] => '/'}
  end

  def self.uri_root
    '/'
  end

  def request
    Rack::Request.new 'REQUEST_METHOD' => 'GET'
  end

  def test_button_to_with_block
    false
  end
end
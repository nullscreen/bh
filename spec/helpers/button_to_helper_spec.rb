require 'spec_helper'

require 'bh/helpers/button_to_helper'
require 'bh/helpers/navbar_helper'

include Bh::ButtonToHelper
include Bh::NavbarHelper

describe 'button_to' do
  let(:protect_against_forgery?) { false }
  attr_accessor :output_buffer
  let(:url) { '/' }

  context 'used without a block' do
    let(:button) { button_to 'Home', url }

    specify 'by default, applies the "btn" class' do
      expect(button).to include 'input class="btn" type="submit" value="Home"'
    end

    specify 'inside a navbar, also applies the "navbar-form" class to the form' do
      expect(navbar { button }).to match %r{<form .+?class="navbar-form" .+?input class="btn"}
    end
  end
end
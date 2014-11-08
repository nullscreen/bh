shared_examples_for 'the nav helper' do
  require 'bh/helpers/nav_helper'
  include Bh::NavHelper

  all_tests_pass_with 'no nav options'
  all_tests_pass_with 'extra nav options'
  all_tests_pass_with 'the :as nav option'
  all_tests_pass_with 'the :layout nav option'
  all_tests_pass_with 'nav inside a navbar'
end

#--

shared_examples_for 'no nav options' do
  specify 'creates a <ul> element with the "tablist" role' do
    button = %r{<ul class="nav nav-tabs" role="tablist">}m
    expect(nil).to generate_nav_with button
  end
end

shared_examples_for 'extra nav options' do
  specify 'passes the options to the <ul> element' do
    button = %r{<ul class="important nav nav-tabs" data-value="1" id="my-nav" role="tablist">block</ul>}m
    expect(class: :important, id: 'my-nav', data: {value: 1}).to generate_nav_with button
  end
end

shared_examples_for 'the :as nav option' do
  Bh::Nav.new.styles.each do |style, style_class|
    specify %Q{set to :#{context}, sets the class "#{style_class}"} do
      button = %r{<ul class="nav #{style_class}" role="tablist">}m
      expect(as: style).to generate_nav_with button
    end
  end
end

shared_examples_for 'the :layout nav option' do
  Bh::Nav.new.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      button = %r{<ul class="nav nav-tabs #{layout_class}" role="tablist">}m
      expect(layout: layout).to generate_nav_with button
    end
  end
end

shared_examples_for 'nav inside a navbar' do
  require 'bh/helpers/navbar_helper'
  include Bh::NavbarHelper

  specify 'creates a <ul> element with the "navbar-nav" class' do
    html = '<ul class="nav navbar-nav">block </ul>'
    expect(navbar { nav { 'block '} }).to include html
  end
end

#--

RSpec::Matchers.define :generate_nav_with do |regex|
  match do |options|
    block = nav(*[options].compact) { 'block' }
    block.include?('block') && block.match(regex)
  end
end
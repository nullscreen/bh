shared_examples_for 'the navbar helper' do
  require 'bh/helpers/navbar_helper'
  include Bh::NavbarHelper

  all_tests_pass_with 'no navbar options'
  all_tests_pass_with 'the :fluid navbar option'
  all_tests_pass_with 'the :inverted navbar option'
  all_tests_pass_with 'the :position navbar option'
  all_tests_pass_with 'the :padding navbar option'
  all_tests_pass_with 'the :id navbar option'
  all_tests_pass_with 'multiple navbars'
end

#--

shared_examples_for 'no navbar options' do
  specify 'creates a <nav> element with a nested grid <div>' do
    html = %r{<nav class="navbar navbar-default" role="navigation">.*<div class="container">.*?</div>.*</nav>}m
    expect(nil).to generate_navbar_with html
  end
end

shared_examples_for 'the :id navbar option' do
  let(:id) { 'my-navbar' }
  let(:html) { navbar(id: id) {safe_join [vertical, horizontal]} }
  it 'uses the id for the vertical and horizontal elements' do
    expect(html).to include %Q{button class="navbar-toggle" data-target="##{id}"}
    expect(html).to include %Q{div class="collapse navbar-collapse" id="#{id}"}
  end
end

shared_examples_for 'multiple navbars' do
  let(:navbar_1) { navbar(inverted: true) {safe_join [vertical, horizontal]} }
  let(:navbar_2) { navbar(position: :top) {safe_join [vertical, horizontal]} }
  let(:html) { safe_join [navbar_1, navbar_2], "\n"}

  specify 'toggle their own horizontal part when clicking on vertical' do
    navbar_ids = html.scan %r{<nav.+?data-target="#(.+?)".+?id="(\1)".+?</nav>}m

    expect(navbar_ids.size).to eq 2
    expect(navbar_ids.uniq.size).to eq 2
  end
end

shared_examples_for 'the :fluid navbar option' do
  Bh::Navbar.new.layouts.each do |value, fluid_class|
    specify %Q{set to #{value}, sets the class "#{fluid_class}"} do
      html = %r{<nav class="navbar navbar-default" role="navigation">.*<div class="#{fluid_class}">.*?</div>.*</nav>}m
      expect(fluid: value).to generate_navbar_with html
    end
  end
end

shared_examples_for 'the :inverted navbar option' do
  Bh::Navbar.new.styles.each do |value, inverted_class|
    specify %Q{set to #{value}, sets the class "#{inverted_class}"} do
      html = %r{<nav class="navbar #{inverted_class}" role="navigation">.*<div class="container">.*?</div>.*</nav>}m
      expect(inverted: value).to generate_navbar_with html
    end
  end
end

shared_examples_for 'the :position navbar option' do
  Bh::Navbar.new.positions.each do |position, position_class|
    specify %Q{set to #{position}, sets the class "#{position_class}"} do
    html = %r{<nav class="navbar navbar-default #{position_class}" role="navigation">.*?<div class="container">.*?</div>.*</nav>}m
      expect(position: position).to generate_navbar_with html
    end
  end
end

shared_examples_for 'the :padding navbar option' do
  specify %Q{set to a value, uses that value for fixed positions} do
    html = %r{<style>body {padding-top: 100px}</style>}m
    expect(position: :top, padding: 100).to generate_navbar_with html
    html = %r{<style>body {padding-bottom: 100px}</style>}m
    expect(position: :bottom, padding: 100).to generate_navbar_with html
  end

  specify %Q{not set, uses a default value of 70px for fixed positions} do
    html = %r{<style>body {padding-top: 70px}</style>}m
    expect(position: :top).to generate_navbar_with html
    html = %r{<style>body {padding-bottom: 70px}</style>}m
    expect(position: :bottom).to generate_navbar_with html
  end
end

#--

RSpec::Matchers.define :generate_navbar_with do |regex|
  match do |options|
    block = navbar(*[options].compact) { 'block' }
    block.include?('block') && block.match(regex)
  end
end
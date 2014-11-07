shared_examples_for 'the icon helper' do
  require 'bh/helpers/icon_helper'
  include Bh::IconHelper

  all_tests_pass_with 'no icon name'
  all_tests_pass_with 'the icon name with underscores'
  all_tests_pass_with 'the icon name with dashes'
  all_tests_pass_with 'the :library icon option'
  all_tests_pass_with 'extra icon options'
end

#--

shared_examples_for 'no icon name' do
  specify 'creates a <span> without any icon class' do
    expect([]).to generate_icon_with 'class="glyphicon"'
  end
end

shared_examples_for 'the icon name with underscores' do
  specify 'creates a <span> with the icon class' do
    expect([:zoom_in]).to generate_icon_with 'class="glyphicon glyphicon-zoom-in"'
  end
end

shared_examples_for 'the icon name with dashes' do
  specify 'creates a <span> with the icon class' do
    expect(['zoom-in']).to generate_icon_with 'class="glyphicon glyphicon-zoom-in"'
  end
end

shared_examples_for 'extra icon options' do
  specify 'passes the options to the <span>' do
    expect([:ok, title: 'Approved']).to generate_icon_with 'title="Approved"'
  end
end

shared_examples_for 'the :library icon option' do
  specify 'set to glyphicon, shows a Glyphicons icon' do
    expect(icon :heart, library: :glyphicon).to eq '<span class="glyphicon glyphicon-heart"></span>'
  end

  specify 'set to font-awesome, shows a Font Awesome icon' do
    expect(icon :heart, library: 'font-awesome').to eq '<span class="fa fa-heart"></span>'
  end

  specify 'set to font_awesome, shows a Font Awesome icon' do
    expect(icon :heart, library: :font_awesome).to eq '<span class="fa fa-heart"></span>'
  end

  specify 'set to any other string, uses the string as a prefix' do
    expect(icon :heart, library: :custom).to eq '<span class="custom custom-heart"></span>'
  end

  specify 'missing, shows a Glyphicons icon' do
    expect(icon :heart).to eq '<span class="glyphicon glyphicon-heart"></span>'
  end
end

#--

RSpec::Matchers.define :generate_icon_with do |attribute|
  match do |args|
    inline = icon *args
    inline.match %r{^<span.*?#{attribute}.*?></span>$}m
  end
end
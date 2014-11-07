shared_examples_for 'the glyphicon helper' do
  require 'bh/helpers/glyphicon_helper'
  include Bh::GlyphiconHelper

  all_tests_pass_with 'no glyphicon name'
  all_tests_pass_with 'the glyphicon name with underscores'
  all_tests_pass_with 'the glyphicon name with dashes'
  all_tests_pass_with 'extra glyphicon options'
end

#--

shared_examples_for 'no glyphicon name' do
  specify 'creates a <span> without any icon class' do
    expect([]).to generate_glyphicon_with 'class="glyphicon"'
  end
end

shared_examples_for 'the glyphicon name with underscores' do
  specify 'creates a <span> with the icon class' do
    expect([:zoom_in]).to generate_glyphicon_with 'class="glyphicon glyphicon-zoom-in"'
  end
end

shared_examples_for 'the glyphicon name with dashes' do
  specify 'creates a <span> with the icon class' do
    expect(['zoom-in']).to generate_glyphicon_with 'class="glyphicon glyphicon-zoom-in"'
  end
end

shared_examples_for 'extra glyphicon options' do
  specify 'passes the options to the <span>' do
    expect([:ok, title: 'Approved']).to generate_glyphicon_with 'title="Approved"'
  end
end

#--

RSpec::Matchers.define :generate_glyphicon_with do |attribute|
  match do |args|
    inline = glyphicon *args
    inline.match %r{^<span.*?#{attribute}.*?></span>$}m
  end
end
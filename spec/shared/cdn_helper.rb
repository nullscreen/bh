shared_examples_for 'the bootstrap_css helper' do
  it { expect(:bootstrap_css).to link_to_existing_file }
end

shared_examples_for 'the bootstrap_theme_css helper' do
  it { expect(:bootstrap_theme_css).to link_to_existing_file }
end

shared_examples_for 'the bootstrap_js helper' do
  it { expect(:bootstrap_js).to link_to_existing_file }
end

shared_examples_for 'the font_awesome_css helper' do
  it { expect(:font_awesome_css).to link_to_existing_file }
end

#--

RSpec::Matchers.define :link_to_existing_file do
  match do |helper|
    require 'open-uri'
    open_uri_options = {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}

    # via HTTP
    open bh.send(helper, scheme: :http), open_uri_options

    # via HTTPS
    open bh.send(helper, scheme: :https), open_uri_options

    # non-minified
    open bh.send(helper, scheme: :http, minified: false), open_uri_options

    # legacy version
    open bh.send(helper, scheme: :http, version: '3.1.0'), open_uri_options
  end
end
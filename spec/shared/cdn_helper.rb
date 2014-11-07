shared_examples_for 'the bootstrap_css helper' do
  it_behaves_like('a cdn helper') { let(:method) { :bootstrap_css } }
end

shared_examples_for 'the bootstrap_theme_css helper' do
  it_behaves_like('a cdn helper') { let(:method) { :bootstrap_theme_css } }
end

shared_examples_for 'the bootstrap_js helper' do
  it_behaves_like('a cdn helper') { let(:method) { :bootstrap_js } }
end

shared_examples_for 'the font_awesome_css helper' do
  it_behaves_like('a cdn helper') { let(:method) { :font_awesome_css } }
end

#--

shared_examples_for 'a cdn helper' do
  require 'bh/helpers/cdn_helper'
  include Bh::CdnHelper
  require 'open-uri'
  let(:open_uri_options) { {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE} }
  let(:file) { open send(method, options), open_uri_options }

  describe 'with the :scheme option set to :http', slow: true do
    let(:options) { {scheme: :http} }
    it('links to an existing file') { expect(file).to be }
  end

  describe 'with the :scheme option set to :https', slow: true do
    let(:options) { {scheme: :https} }
    it('links to an existing file') { expect(file).to be }
  end

  describe 'with the :minified option set to false', slow: true do
    let(:options) { {scheme: :http, minified: false} }
    it('links to an existing file') { expect(file).to be }
  end

  describe 'with the :version option set to a legacy version', slow: true do
    let(:options) { {scheme: :https, version: '3.1.0'} }
    it('links to an existing file') { expect(file).to be }
  end
end

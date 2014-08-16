require 'spec_helper'
require 'bh/helpers/cdn_helper'
require 'open-uri'
include Bh::CdnHelper

describe 'bootstrap_css' do
  let(:file) { open bootstrap_css(options), ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }

  describe 'with the HTTP scheme, links to an existing file' do
    let(:options) { {scheme: :http} }
    it{ expect(file).to be }
  end

  describe 'with the HTTPS scheme, links to an existing file' do
    let(:options) { {scheme: :https} }
    it{ expect(file).to be }
  end

  describe 'non-minified, links to an existing file' do
    let(:options) { {scheme: :http, minified: false} }
    it{ expect(file).to be }
  end

  describe 'given a legacy version, links to an existing file' do
    let(:options) { {scheme: :https, version: '3.1.0'} }
    it{ expect(file).to be }
  end
end

describe 'bootstrap_theme_css' do
  let(:file) { open bootstrap_theme_css(options), ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }

  describe 'with the HTTP scheme, links to an existing file' do
    let(:options) { {scheme: :http} }
    it{ expect(file).to be }
  end

  describe 'with the HTTPS scheme, links to an existing file' do
    let(:options) { {scheme: :https} }
    it{ expect(file).to be }
  end

  describe 'non-minified, links to an existing file' do
    let(:options) { {scheme: :http, minified: false} }
    it{ expect(file).to be }
  end

  describe 'given a legacy version, links to an existing file' do
    let(:options) { {scheme: :https, version: '3.1.0'} }
    it{ expect(file).to be }
  end
end

describe 'bootstrap_js' do
  let(:file) { open bootstrap_js(options), ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }

  describe 'with the HTTP scheme, links to an existing file' do
    let(:options) { {scheme: :http} }
    it{ expect(file).to be }
  end

  describe 'with the HTTPS scheme, links to an existing file' do
    let(:options) { {scheme: :https} }
    it{ expect(file).to be }
  end

  describe 'non-minified, links to an existing file' do
    let(:options) { {scheme: :http, minified: false} }
    it{ expect(file).to be }
  end

  describe 'given a legacy version, links to an existing file' do
    let(:options) { {scheme: :https, version: '3.1.0'} }
    it{ expect(file).to be }
  end
end
shared_examples_for 'the link_to helper' do
  alias rails_link_to link_to

  require 'bh/core_ext/rails/link_to_helper'
  include Bh::Rails::Helpers

  all_tests_pass_with '"alert_box" wrapping link_to'
  all_tests_pass_with '"dropdown" wrapping link_to'
  all_tests_pass_with '"nav" wrapping link_to'
  all_tests_pass_with '"vertical" wrapping link_to'
end

#--

shared_examples_for '"alert_box" wrapping link_to' do
  require 'bh/helpers/alert_box_helper'
  include Bh::AlertBoxHelper

  describe 'adds the "alert-link" class to the link' do
    let(:override) { link_to 'inline', '/' }
    let(:original) { rails_link_to 'inline', '/', class: 'alert-link' }
    it { expect(alert_box{ override }).to eq alert_box{ original } }
  end

  describe 'adds the "alert-link" class to the link' do
    let(:override) { link_to 'inline', '/', class: :article, method: :delete }
    let(:original) { rails_link_to 'inline', '/', class: 'article alert-link', method: :delete }
    it { expect(alert_box{ override }).to eq alert_box{ original } }
  end

  describe 'adds the "alert-link" class to the link' do
    let(:override) { link_to('/') { 'block' } }
    let(:original) { rails_link_to('/', class: 'alert-link') { 'block' } }
    it { expect(alert_box{ override }).to eq alert_box{ original } }
  end

  describe 'adds the "alert-link" class to the link', fodcus: true do
    let(:override) { link_to('/', class: :article, method: :delete) { 'block' } }
    let(:original) { rails_link_to('/', class: 'article alert-link', method: :delete) { 'block' } }
    it { expect(alert_box{ override }).to eq alert_box{ original } }
  end
end

shared_examples_for '"dropdown" wrapping link_to' do
  require 'bh/helpers/dropdown_helper'
  include Bh::DropdownHelper
  before { allow_any_instance_of(Bh::Dropdown).to receive(:id).and_return 'dropdown-id' }

  describe 'surrounds the link in a <li> with dropdown role and tabindex' do
    let(:override) { link_to 'inline', '/' }
    let(:original_link) { rails_link_to 'inline', '/', role: 'menuitem', tabindex: '-1' }
    let(:original) { content_tag :li, original_link, role: :presentation }
    it { expect(dropdown(''){ override }).to eq dropdown(''){ original } }
  end

  describe 'surrounds the link in a <li> with dropdown role and tabindex' do
    let(:override) { link_to 'inline', '/', class: :article, method: :delete }
    let(:original_link) { rails_link_to 'inline', '/', class: 'article', role: 'menuitem', tabindex: '-1', method: :delete }
    let(:original) { content_tag :li, original_link, role: :presentation }
    it { expect(dropdown(''){ override }).to eq dropdown(''){ original } }
  end

  describe 'surrounds the link in a <li> with dropdown role and tabindex' do
    let(:override) { link_to('/') { 'block' } }
    let(:original_link) { rails_link_to('/', role: 'menuitem', tabindex: '-1') { 'block' } }
    let(:original) { content_tag :li, original_link, role: :presentation }
    it { expect(dropdown(''){ override }).to eq dropdown(''){ original } }
  end

  describe 'surrounds the link in a <li> with dropdown role and tabindex' do
    let(:override) { link_to('/', class: :article, method: :delete) { 'block' } }
    let(:original_link) { rails_link_to('/', class: 'article', role: 'menuitem', tabindex: '-1', method: :delete) { 'block' } }
    let(:original) { content_tag :li, original_link, role: :presentation }
    it { expect(dropdown(''){ override }).to eq dropdown(''){ original } }
  end
end

shared_examples_for '"nav" wrapping link_to' do
  require 'bh/helpers/nav_helper'
  include Bh::NavHelper

  describe 'surrounds the link in a <li> item' do
    let(:override) { link_to 'inline', '/' }
    let(:original_link) { rails_link_to 'inline', '/' }
    let(:original) { content_tag :li, original_link }
    it { expect(nav{ override }).to eq nav{ original } }
  end

  describe 'surrounds the link in a <li> item' do
    let(:override) { link_to('/') { 'block' } }
    let(:original_link) { rails_link_to('/') { 'block' } }
    let(:original) { content_tag :li, original_link }
    it { expect(nav{ override }).to eq nav{ original } }
  end

  describe 'sets the class to "active" if the link is the current page' do
    before { allow(self).to receive(:current_page?).and_return true }

    let(:override) { link_to 'inline', '/' }
    let(:original_link) { rails_link_to 'inline', '/' }
    let(:original) { content_tag :li, original_link, class: :active }
    it { expect(nav{ override }).to eq nav{ original } }
  end
end

shared_examples_for '"vertical" wrapping link_to' do
  require 'bh/helpers/vertical_helper'
  include Bh::VerticalHelper

  describe 'adds the "navbar-brand" class to the link' do
    let(:override) { link_to 'inline', '/' }
    let(:original) { rails_link_to 'inline', '/', class: 'navbar-brand' }
    it { expect(vertical{ override }).to eq vertical{ original } }
  end

  describe 'adds the "navbar-brand" class to the link' do
    let(:override) { link_to 'inline', '/', class: :article, method: :delete }
    let(:original) { rails_link_to 'inline', '/', class: 'article navbar-brand', method: :delete }
    it { expect(vertical{ override }).to eq vertical{ original } }
  end

  describe 'adds the "navbar-brand" class to the link' do
    let(:override) { link_to('/') { 'block' } }
    let(:original) { rails_link_to('/', class: 'navbar-brand') { 'block' } }
    it { expect(vertical{ override }).to eq vertical{ original } }
  end

  describe 'adds the "navbar-brand" class to the link', fodcus: true do
    let(:override) { link_to('/', class: :article, method: :delete) { 'block' } }
    let(:original) { rails_link_to('/', class: 'article navbar-brand', method: :delete) { 'block' } }
    it { expect(vertical{ override }).to eq vertical{ original } }
  end
end
shared_examples_for 'the modal helper' do
  require 'bh/helpers/modal_helper'
  include Bh::ModalHelper

  all_tests_pass_with 'no modal options'
  all_tests_pass_with 'the :id modal option'
  all_tests_pass_with 'the :body modal option'
  all_tests_pass_with 'the :title modal option'
  all_tests_pass_with 'the :size modal option'
  all_tests_pass_with 'the button: :caption modal option'
  all_tests_pass_with 'the button: :context modal option'
  all_tests_pass_with 'the button: :size modal option'
end

#--

shared_examples_for 'no modal options' do
  specify 'sets the role and the class to "modal", uses a generated ID and uses "Modal" as the title and caption' do
    expect(nil).to generate_modal_with %r{<button class="btn btn-default" data-toggle="modal" data-target="#(.+?)">Modal</button>.+?<div class="modal fade" id="\1" tabindex="-1" role="dialog" aria-labelledby="label-modal-.+?" aria-hidden="true">}m
    expect(nil).to generate_modal_with %Q{<h4 class="modal-title" id="label-modal-.+?">Modal</h4>}
  end
end

shared_examples_for 'the :id modal option' do
  specify 'uses the ID to connect button and modal' do
    expect(modal id: 'my-modal').to match %r{<button.+?data-target="#my-modal">.+?<div class="modal fade" id="my-modal"}m
  end
end

shared_examples_for 'the :body modal option' do
  context 'given neither a content nor a block' do
    let(:html) { modal body: 'Body' }

    specify 'sets the body of the modal to the specified value' do
      expect(html).to include %Q{<div class="modal-body">Body</div>}
    end
  end

  context 'given a content' do
    let(:html) { modal 'content', body: 'Body' }

    specify 'ignores the :body option and uses the content' do
      expect(html).not_to include %Q{<div class="modal-body">Body</div>}
      expect(html).to include %Q{<div class="modal-body">content</div>}
    end
  end

  context 'given a block' do
    let(:html) { modal(body: 'Body') { 'block' } }

    specify 'ignores the :body option and uses the block' do
      expect(html).not_to include %Q{<div class="modal-body">Body</div>}
      expect(html).to include %Q{block}
    end
  end
end

shared_examples_for 'the :title modal option' do
  specify 'sets the modal title to the given value' do
    expect(title: 'Title').to generate_modal_with %Q{<h4 class="modal-title".+>Title</h4>}
  end
end

shared_examples_for 'the :size modal option'do
  Bh::Modal.new.dialog_sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"}  do
      expect(size: size.to_s).to generate_modal_with %Q{<div class="modal-dialog #{size_class}">}
    end
  end
end

shared_examples_for 'the button: :caption modal option' do
  let(:caption) { 'Click to toggle modal' }

  specify 'sets the button caption to the given value' do
    expect(button: {caption: caption}).to generate_modal_with %Q{<button.+>#{caption}</button>}
  end
end

shared_examples_for 'the button: :context modal option' do
  Bh::Button.new.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      expect(button: {context: context.to_s}).to generate_modal_with %Q{<button class="btn #{context_class}"}
    end
  end
end

shared_examples_for 'the button: :size modal option' do
  Bh::Button.new.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      expect(button: {size: size.to_s}).to generate_modal_with %Q{<button class="btn btn-default #{size_class}"}
    end
  end
end

#--

RSpec::Matchers.define :generate_modal_with do |regex|
  match do |options|
    inline = modal *['inline', options].compact
    inline_match = inline.include?(%Q{<div class="modal-body">inline</div>}) && inline.match(regex)

    block = modal(*[options].compact) { 'block' }
    block_match = block.include?('block') && block.match(regex)

    inline_match && block_match
  end
end
shared_examples_for 'the modal helper' do
  all_tests_pass_with 'no modal options'
  all_tests_pass_with 'the :id modal option'
  all_tests_pass_with 'the :body modal option'
  all_tests_pass_with 'the :title modal option'
  all_tests_pass_with 'the :size modal option'
  all_tests_pass_with 'the button: :caption modal option'
  all_tests_pass_with 'the button: :context modal option'
  all_tests_pass_with 'the button: :size modal option'
  all_tests_pass_with 'the button: :class modal option'
end

#--

shared_examples_for 'no modal options' do
  specify 'sets the role and the class to "modal", uses a generated ID and uses "Modal" as the title and caption' do
    html = <<-EOT.strip_heredoc.strip
      <button class="btn btn-default" data-toggle="modal" data-target="#(.+)">Modal<\/button>
      <div class="modal fade" id="\\1" tabindex="-1" role="dialog" aria-labelledby="label-\\1" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;<\/span><span class="sr-only">Close<\/span>
              <\/button>
              <h4 class="modal-title" id="label-\\1">Modal<\/h4>
            <\/div>
            (<div class=\"modal-body\">)*content(</div>)*
          <\/div>
        <\/div>
      <\/div>
    EOT
    expect(:modal).to generate %r{#{html}}
  end
end

shared_examples_for 'the :id modal option' do
  specify 'uses the ID to connect button and modal' do
    id = 'my-modal'
    expect(modal: {id: id}).to generate %r{<button.+data-target="##{id}">Modal<\/button>}
    expect(modal: {id: id}).to generate %r{<div.+id="#{id}".+aria-labelledby="label-#{id}".+>}
    expect(modal: {id: id}).to generate %r{<h4.+id="label-#{id}">Modal<\/h4>}
  end
end

shared_examples_for 'the :body modal option' do
  let(:html) { %r{<div class="modal-body">Body</div>} }

  specify 'given either a content or a block, is ignored' do
    expect(modal: {body: 'Body'}).not_to generate html
  end

  specify 'given neither content nor a block, it is displayed as the content' do
    expect(bh.modal(body: 'Body')).to match html
  end
end

shared_examples_for 'the :title modal option' do
  specify 'sets the modal title to the given value' do
    html = %r{<h4 class="modal-title".+>Title</h4>}
    expect(modal: {title: 'Title'}).to generate html
  end
end

shared_examples_for 'the :size modal option'do
  Bh::Modal.dialog_sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"}  do
      html = %r{<div class="modal-dialog #{size_class}">}
      expect(modal: {size: size}).to generate html
    end
  end
end

shared_examples_for 'the button: :caption modal option' do
  specify 'sets the button caption to the given value' do
    html = %r{<button.+>Click me</button>}
    expect(modal: {button: {caption: 'Click me'}}).to generate html
  end
end

shared_examples_for 'the button: :context modal option' do
  Bh::Button.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %r{<button class="btn #{context_class}"}
      expect(modal: {button: {context: context}}).to generate html
    end
  end
end

shared_examples_for 'the button: :size modal option' do
  Bh::Button.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      html = %r{<button class="btn btn-default #{size_class}"}
      expect(modal: {button: {size: size}}).to generate html
    end
  end
end

shared_examples_for 'the button: :class modal option' do
  specify 'appends the class to the modal button' do
    html = %r{<button class="important btn btn-default"}
    expect(modal: {button: {class: 'important'}}).to generate html
  end
end
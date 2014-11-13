shared_examples_for 'the button_to helper (Padrino)' do
  all_tests_pass_with 'no button_to options (Padrino)'
  all_tests_pass_with 'only extra button_to options (Padrino)'
  all_tests_pass_with 'extra button_to options (Padrino)'
  all_tests_pass_for 'the button_to helper'
end

#--

shared_examples_for 'no button_to options (Padrino)' do
  specify 'uses the original button_to helper' do
    html = '<form action="/" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" /><input type="submit" value="content" /></form>'
    expect(:button_to).to generate html

    # @note: Only Padrino >= 0.13.0 renders the content of the block as a
    #        <button> so the exact content is only partially tested here.
    expect(bh.button_to('/'){ 'content' }).to include 'content'
  end
end

shared_examples_for 'only extra button_to options (Padrino)' do
  specify 'uses the original button_to helper' do
    options = {class: 'big', id: 'my-form', submit_options: {class: 'important', data: {value: 1}, id: 'my-button_to'}}
    html = '<form action="/" accept-charset="UTF-8" class="big" id="my-form" method="post"><input type="hidden" name="authenticity_token" /><input type="submit" value="content" class="important" data-value="1" id="my-button_to" /></form>'
    expect(button_to: options).to generate html
  end
end

shared_examples_for 'extra button_to options (Padrino)' do
  specify 'passes the options to the form and the submit_options to the button' do
    options = {context: :default, class: 'big', id: 'my-form', submit_options: {class: 'important', data: {value: 1}, id: 'my-button_to'}}
    html = '<form action="/" accept-charset="UTF-8" class="big" id="my-form" method="post"><input type="hidden" name="authenticity_token" /><input type="submit" value="content" class="important btn btn-default" data-value="1" id="my-button_to" /></form>'
    expect(button_to: options).to generate html
  end
end

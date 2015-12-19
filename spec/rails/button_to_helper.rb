shared_examples_for 'the button_to helper (Rails)' do
  all_tests_pass_with 'no button_to options (Rails)'
  all_tests_pass_with 'only extra button_to options (Rails)'
  all_tests_pass_with 'extra button_to options (Rails)'
  all_tests_pass_for 'the button_to helper'
end

#--

shared_examples_for 'no button_to options (Rails)' do
  specify 'uses the original button_to helper' do
    html = %r{^<form(?:| action="/") class="button_to" method="post"(?:| action="/")>(?:|<div>)<(input|button) type="submit"(>| value=")content(" />|</button>)(?:|</div>)</form>$}
    expect(:button_to).to generate html
  end
end

shared_examples_for 'only extra button_to options (Rails)' do
  specify 'uses the original button_to helper' do
    options = {class: 'important', data: {value: 1}, id: 'my-button_to'}
    html = %r{<(input|button) class="important" data-value="1" id="my-button_to" type="submit"}
    expect(button_to: options).to generate html
  end
end

shared_examples_for 'extra button_to options (Rails)' do
  specify 'passes the options to the button' do
    options = {context: :default, class: 'important', data: {value: 1}, id: 'my-button_to'}
    html = %r{<(input|button) class="important btn btn-default" data-value="1" id="my-button_to" type="submit"}
    expect(button_to: options).to generate html
  end
end

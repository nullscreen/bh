shared_examples_for 'the horizontal helper' do
  all_tests_pass_with 'the horizontal not wrapped in navbar'
  all_tests_pass_with 'no horizontal options'
  all_tests_pass_with 'extra horizontal options (except :id)'
  all_tests_pass_with 'the horizontal wrapped in a navbar with :id'
end

#--

shared_examples_for 'the horizontal not wrapped in navbar' do
  specify 'returns nil' do
    expect(:horizontal).to generate nil
  end
end

shared_examples_for 'no horizontal options' do
  specify 'creates a <div class="collpase navbar-collapse"> element' do
    html = %r{<div class="collapse navbar-collapse" id=".+">content</div>}
    bh.navbar { expect(:horizontal).to generate html }
  end
end

shared_examples_for 'extra horizontal options (except :id)' do
  specify 'passes the options to the <div> element' do
    options = {class: 'important', data: {value: 1}}
    html = %r{<div class="important collapse navbar-collapse" data-value="1"}
    bh.navbar { expect(horizontal: options).to generate html }
  end
end

shared_examples_for 'the horizontal wrapped in a navbar with :id' do
  it 'uses the id from the navbar' do
    id = 'my-navbar'
    html = %r{<div class="collapse navbar-collapse" id="my-navbar">content</div>}
    bh.navbar(id: id) { expect(:horizontal).to generate html}
  end
end
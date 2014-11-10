shared_examples_for 'the glyphicon helper' do
  all_tests_pass_with 'no glyphicon options'
  all_tests_pass_with 'extra glyphicon options'
end

#--

shared_examples_for 'no glyphicon options' do
  specify 'creates a <span> with an icon' do
    html = '<span class="glyphicon glyphicon-zoom-in"></span>'
    expect(:glyphicon).to generate html
  end
end

shared_examples_for 'extra glyphicon options' do
  specify 'passes the options to the <span>' do
    options = {class: 'important', data: {value: 1}, id: 'my-glyphicon'}
    html = '<span class="important glyphicon glyphicon-zoom-in" data-value="1" id="my-glyphicon"></span>'
    expect(glyphicon: options).to generate html
  end
end
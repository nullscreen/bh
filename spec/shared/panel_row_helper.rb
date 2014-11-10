shared_examples_for 'the panel_row helper' do
  all_tests_pass_with 'no panel_row options'
  all_tests_pass_with 'extra panel_row options'
end

#--

shared_examples_for 'no panel_row options' do
  specify 'displays an <div> with class="row"' do
    html = '<div class="row">content</div>'
    expect(:panel_row).to generate html
  end
end

shared_examples_for 'extra panel_row options' do
  specify 'passes the options to the <div>' do
    options = {class: 'important', data: {value: 1}, id: 'my-panel-row'}
    html = '<div class="important row" data-value="1" id="my-panel-row">content</div>'
    expect(panel_row: options).to generate html
  end
end
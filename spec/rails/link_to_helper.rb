shared_examples_for 'the link_to helper (Rails)' do
  all_tests_pass_with 'no link_to caption (Rails)'
end

#--

shared_examples_for 'no link_to caption (Rails)' do
  specify 'uses the original link_to helper which sets the link to the caption' do
    html = '<a href="/">/</a>'
    expect(link_to: :nil_name).to generate html
  end
end

shared_examples_for 'the link_to helper (Padrino)' do
  all_tests_pass_with 'no link_to caption (Padrino)'
end

#--

shared_examples_for 'no link_to caption (Padrino)' do
  specify 'uses the original link_to helper which sets an empty link text' do
    html = '<a href="/"></a>'
    expect(link_to: :nil_name).to generate html
  end
end

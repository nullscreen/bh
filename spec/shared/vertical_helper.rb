shared_examples_for 'the vertical helper' do
  all_tests_pass_with 'the vertical not wrapped in navbar'
  all_tests_pass_with 'no vertical options'
  all_tests_pass_with 'extra vertical options'
  all_tests_pass_with 'the vertical wrapped in a navbar with :id'
end

#--

shared_examples_for 'the vertical not wrapped in navbar' do
  specify 'returns nil' do
    expect(:vertical).to generate nil
  end
end

shared_examples_for 'no vertical options' do
  specify 'creates a <div> element with the "navbar-header" class and toggle button' do
    html = <<-EOT.strip_heredoc.strip
      <div class="navbar-header"><button class="navbar-toggle" data-target="#(.+)" data-toggle="collapse" type="button"><span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span></button>
      content</div>
    EOT
    bh.navbar { expect(:vertical).to generate %r{#{html}} }
  end
end

shared_examples_for 'extra vertical options' do
  specify 'passes the options to the <div> element' do
    options = {class: 'important', data: {value: 1}, id: 'my-navbar-header'}
    html = %r{<div class="important navbar-header" data-value="1" id="my-navbar-header">}
    bh.navbar { expect(vertical: options).to generate html }
  end
end

shared_examples_for 'the vertical wrapped in a navbar with :id' do
  it 'uses the id from the navbar' do
    id = 'my-navbar'
    html = %r{button class="navbar-toggle" data-target="##{id}"}
    bh.navbar(id: id) { expect(:vertical).to generate html}
  end
end
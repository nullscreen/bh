shared_examples_for 'the panel helper' do
  all_tests_pass_with 'no panel options'
  all_tests_pass_with 'extra panel options (except :id)'
  all_tests_pass_with 'the :heading panel option'
  all_tests_pass_with 'the :title panel option'
  all_tests_pass_with 'the :body panel option'
  all_tests_pass_with 'the :context panel option'
  all_tests_pass_with 'the :tag panel option'
  all_tests_pass_with 'the panel wrapped in panel_row'
end

#--

shared_examples_for 'no panel options' do
  specify 'displays a <div> with class="panel panel-default"' do
    html = %r{^<div class="panel panel-default">(?:|<div class="panel-body">)content(?:|</div>)</div>$}
    expect(:panel).to generate html
  end
end

shared_examples_for 'extra panel options (except :id)' do
  specify 'passes the options to the <div> panel' do
    options = {class: 'important', data: {value: 1}}
    html = %r{^<div class="important panel panel-default" data-value="1">(?:|<div class="panel-body">)content(?:|</div>)</div>$}
    expect(panel: options).to generate html
  end
end

shared_examples_for 'the :heading panel option' do
  specify 'sets the heading of the panel to the specified value' do
    html = %r{^<div class="panel panel-default"><div class="panel-heading">Heading</div>}
    expect(panel: {heading: 'Heading'}).to generate html
  end
end

shared_examples_for 'the :title panel option' do
  specify 'sets the title of the panel to the specified value' do
    html = %r{^<div class="panel panel-default"><div class="panel-heading"><h3 class="panel-title">Title</h3></div>}
    expect(panel: {title: 'Title'}).to generate html
  end
end

shared_examples_for 'the :body panel option' do
  let(:html) { %r{<div class="panel-body">Body</div>} }

  specify 'given either a content or a block, is ignored' do
    expect(panel: {body: 'Body'}).not_to generate html
  end

  specify 'given neither content nor a block, it is displayed as the content' do
    expect(bh.panel(body: 'Body')).to match html
  end
end

shared_examples_for 'the :tag panel option' do
  specify 'uses the HTML tag instead of <div> to wrap the panel' do
    html =  %r{^<aside class="panel panel-default">.*</aside>$}m
    expect(panel: {tag: :aside}).to generate html
  end
end

shared_examples_for 'the :context panel option' do
  Bh::Panel.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %r{^<div class="panel #{context_class}">.*</div>$}m
      expect(panel: {context: context}).to generate html
    end
  end
end

shared_examples_for 'the panel wrapped in panel_row' do
  specify 'wraps the panel <div> in a grid <div> with the :column_class class of the panel row' do
    html = %r{^<div class="col-sm-4"><div class="panel panel-default">(?:|<div class="panel-body">)content(?:|</div>)</div></div>$}
    bh.panel_row(column_class: 'col-sm-4') { expect(:panel).to generate html }
  end
end
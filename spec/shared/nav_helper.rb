shared_examples_for 'the nav helper' do
  all_tests_pass_with 'no nav options'
  all_tests_pass_with 'extra nav options'
  all_tests_pass_with 'the :as nav option'
  all_tests_pass_with 'the :layout nav option'
  all_tests_pass_with 'the nav wrapped in navbar'
end

#--

shared_examples_for 'no nav options' do
  specify 'creates a <ul> element with the "tablist" role' do
    html = '<ul class="nav nav-tabs" role="tablist">content</ul>'
    expect(:nav).to generate html
  end
end

shared_examples_for 'extra nav options' do
  specify 'passes the options to the <ul> element' do
    options = {class: 'important', data: {value: 1}, id: 'my-alert'}
    html = '<ul class="important nav nav-tabs" data-value="1" id="my-alert" role="tablist">content</ul>'
    expect(nav: options).to generate html
  end
end

shared_examples_for 'the :as nav option' do
  Bh::Nav.styles.each do |style, style_class|
    specify %Q{set to :#{context}, sets the class "#{style_class}"} do
      html = %r{<ul class="nav #{style_class}"}
      expect(nav: {as: style}).to generate html
    end
  end
end

shared_examples_for 'the :layout nav option' do
  Bh::Nav.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      html = %r{<ul class="nav nav-tabs #{layout_class}"}
      expect(nav: {layout: layout}).to generate html
    end
  end
end

shared_examples_for 'the nav wrapped in navbar' do
  specify 'creates a <ul> element with the "navbar-nav" class' do
    html = '<ul class="nav navbar-nav">content</ul>'
    bh.navbar { expect(:nav).to generate html }
  end
end
shared_examples_for 'the link_to helper' do
  all_tests_pass_with 'no link_to options'
  all_tests_pass_with 'extra link_to options'
  all_tests_pass_with 'the link wrapped in alert_box'
  all_tests_pass_with 'the link wrapped in dropdown'
  all_tests_pass_with 'the link wrapped in nav'
  all_tests_pass_with 'the link wrapped in vertical'
end

#--

shared_examples_for 'no link_to options' do
  specify 'matches the behavior of the framework-defined link_to' do
    html = '<a href="/">content</a>'
    expect(:link_to).to generate html
  end
end

shared_examples_for 'extra link_to options' do
  specify 'passes the options to the <a>' do
    options = {class: 'important', data: {value: 1}, id: 'my-link'}
    html = %r{^<a.+class="important" data-value="1".+id="my-link".*>content</a>$}
    expect(link_to: options).to generate html
  end
end

shared_examples_for 'the link wrapped in alert_box' do
  specify 'adds the "alert-link" class to the link' do
    html = %r{^<a.+class="alert-link".*>content</a>$}
    bh.alert_box { expect(:link_to).to generate html }
  end
end

shared_examples_for 'the link wrapped in dropdown' do
  specify 'surrounds the link in a <li> and adds role and tabindex' do
    html = %r{<li role="presentation"><a.+role="menuitem" tabindex="-1".*>content</a></li>}
    bh.dropdown('') { expect(:link_to).to generate html }
  end
end

shared_examples_for 'the link wrapped in nav' do
  specify 'surrounds the link in a <li> item' do
    html = '<li><a href="/">content</a></li>'
    bh.nav { expect(:link_to).to generate html }
  end

  describe 'if the link is to the current page' do
    before { allow_any_instance_of(Bh::LinkTo).to receive(:current_page?).and_return true }

    specify 'surrounds the link in a <li class="active"> item' do
      html = '<li class="active"><a href="/">content</a></li>'
      bh.nav { expect(:link_to).to generate html }
    end
  end

  describe 'if the link is given the active option' do
    specify 'surrounds the link in a <li class="active"> item' do
      options = { active: true }
      html = '<li class="active"><a href="/">content</a></li>'
      bh.nav { expect(link_to: options).to generate html }
    end
  end
end

shared_examples_for 'the link wrapped in vertical' do
  specify 'surrounds the link in a <li> item' do
    html = '<li><a href="/">content</a></li>'
    bh.vertical { expect(:link_to).to generate html }
  end
end
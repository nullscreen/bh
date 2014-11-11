shared_examples_for 'the button_to helper' do
  all_tests_pass_with 'no button_to options'
  all_tests_pass_with 'extra button_to options'
  all_tests_pass_with 'the :context button_to option'
  all_tests_pass_with 'the :size button_to option'
  all_tests_pass_with 'the :layout button_to option'
  all_tests_pass_with 'the button wrapped in navbar'
end

#--

shared_examples_for 'no button_to options' do
  specify 'adds the "btn btn-default" class to the button' do
    html = %r{^<form action="/" class="button_to" method="post"><div><(input|button) class="btn btn-default" type="submit"(>| value=")content(" />|</button>)</div></form>$}
    expect(:button_to).to generate html
  end
end


shared_examples_for 'extra button_to options' do
  specify 'passes the options to the button' do
    options = {class: 'important', data: {value: 1}, id: 'my-button_to'}
    html = %r{<(input|button) class="important btn btn-default" data-value="1" id="my-button_to" type="submit"}
    expect(button_to: options).to generate html
  end
end

shared_examples_for 'the :context button_to option' do
  Bh::Button.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %r{<(input|button) class="btn #{context_class}" type="submit"}
      expect(button_to: {context: context}).to generate html
    end
  end
end

shared_examples_for 'the :size button_to option' do
  Bh::Button.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      html = %r{<(input|button) class="btn btn-default #{size_class}" type="submit"}
      expect(button_to: {size: size}).to generate html
    end
  end
end

shared_examples_for 'the :layout button_to option' do
  Bh::Button.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      html = %r{<(input|button) class="btn btn-default #{layout_class}" type="submit"}
      expect(button_to: {layout: layout}).to generate html
    end
  end
end
shared_examples_for 'the button wrapped in navbar' do
  specify 'adds the "navbar-form" class to the form' do
    html = %r{^<form action="/" class="navbar-form" method="post"><div><(input|button) class="btn btn-default" type="submit"(>| value=")content(" />|</button>)</div></form>$}
    bh.navbar { expect(:button_to).to generate html }
  end
end
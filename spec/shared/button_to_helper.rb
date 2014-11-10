shared_examples_for 'the button_to helper' do
  all_tests_pass_with 'no button_to options'
  all_tests_pass_with 'the button wrapped in navbar'
end

#--

shared_examples_for 'no button_to options' do
  specify 'adds the "btn" class to the button' do
    html = %r{^<form action="/" class="button_to" method="post"><div><(input|button) class="btn" type="submit"(>| value=")content(" />|</button>)</div></form>$}
    expect(:button_to).to generate html
  end
end

shared_examples_for 'the button wrapped in navbar' do
  specify 'adds the "navbar-form" class to the form' do
    html = %r{^<form action="/" class="navbar-form" method="post"><div><(input|button) class="btn" type="submit"(>| value=")content(" />|</button>)</div></form>$}
    bh.navbar { expect(:button_to).to generate html }
  end
end
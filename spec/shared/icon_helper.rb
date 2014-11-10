shared_examples_for 'the icon helper' do
  all_tests_pass_with 'no icon options'
  all_tests_pass_with 'extra icon options'
  all_tests_pass_with 'the :library icon option'
end

#--

shared_examples_for 'no icon options' do
  specify 'creates a <span> with an icon' do
    html = '<span class="glyphicon glyphicon-zoom-in"></span>'
    expect(:icon).to generate html
  end
end

shared_examples_for 'extra icon options' do
  specify 'passes the options to the <span>' do
    options = {class: 'important', data: {value: 1}, id: 'my-icon'}
    html = '<span class="important glyphicon glyphicon-zoom-in" data-value="1" id="my-icon"></span>'
    expect(icon: options).to generate html
  end
end

shared_examples_for 'the :library icon option' do
  Bh::Icon.libraries.each do |library, library_class|
    specify %Q{set to :#{library}, adds the class "#{library_class}"} do
      html = %Q{<span class="#{library_class} #{library_class}-zoom-in"></span>}
      expect(icon: {library: library}).to generate html
    end
  end
end
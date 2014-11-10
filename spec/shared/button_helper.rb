shared_examples_for 'the button helper' do
  all_tests_pass_with 'no button options'
  all_tests_pass_with 'extra button options'
  all_tests_pass_with 'the :context button option'
  all_tests_pass_with 'the :size button option'
  all_tests_pass_with 'the :layout button option'
end

#--

shared_examples_for 'no button options' do
  specify 'sets the class to "btn btn-default"' do
    html = '<button class="btn btn-default">content</button>'
    expect(:button).to generate html
  end
end


shared_examples_for 'extra button options' do
  specify 'passes the options to the wrapping <button>' do
    options = {class: 'important', data: {value: 1}, id: 'my-button'}
    html = '<button class="important btn btn-default" data-value="1" id="my-button">content</button>'
    expect(button: options).to generate html
  end
end

shared_examples_for 'the :context button option' do
  Bh::Button.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %Q{<button class="btn #{context_class}">content</button>}
      expect(button: {context: context}).to generate html
    end
  end
end

shared_examples_for 'the :size button option' do
  Bh::Button.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      html = %Q{<button class="btn btn-default #{size_class}">content</button>}
      expect(button: {size: size}).to generate html
    end
  end
end

shared_examples_for 'the :layout button option' do
  Bh::Button.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      html = %Q{<button class="btn btn-default #{layout_class}">content</button>}
      expect(button: {layout: layout}).to generate html
    end
  end
end
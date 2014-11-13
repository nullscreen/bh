shared_examples_for 'the dropdown helper' do
  all_tests_pass_with 'no dropdown options'
  all_tests_pass_with 'the :id dropdown option'
  all_tests_pass_with 'the :context dropdown option'
  all_tests_pass_with 'the :size dropdown option'
  all_tests_pass_with 'the :layout dropdown option'
  all_tests_pass_with 'the :groupable dropdown option'
  all_tests_pass_with 'the :direction dropdown option'
  all_tests_pass_with 'the :align dropdown option'
  all_tests_pass_with 'the :split dropdown option'
  all_tests_pass_with 'the button: :class dropdown option'
end

#--

shared_examples_for 'no dropdown options' do
  specify 'displays a button with the caption and the caret to toggle a menu' do
    html = <<-EOT.strip_heredoc.strip
      <div class="btn-group">
        <button class="dropdown-toggle btn btn-default" type="button" id="(.+)" data-toggle="dropdown">
          caption
          <span class=\"caret\"><\/span>
        <\/button>
        <ul class=\"dropdown-menu\" role=\"menu\" aria-labelledby=\"\\1\">
          content
        <\/ul>
      <\/div>
    EOT
    expect(:dropdown).to generate %r{#{html}}
  end
end

shared_examples_for 'the :id dropdown option' do
  specify 'uses the ID to connect button and ul' do
    id = 'my-modal'
    expect(dropdown: {id: id}).to generate %r{<button.+id="#{id}".*>}
    expect(dropdown: {id: id}).to generate %r{<ul.+aria-labelledby="#{id}".*>}
  end
end

shared_examples_for 'the :context dropdown option' do
  Bh::Button.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %r{<button class="dropdown-toggle btn #{context_class}"}
      expect(dropdown: {context: context}).to generate html
    end
  end
end

shared_examples_for 'the :size dropdown option' do
  Bh::Button.sizes.each do |size, size_class|
    specify %Q{set to :#{size}, adds the class "#{size_class}"} do
      html = %r{<button class="dropdown-toggle btn btn-default #{size_class}"}
      expect(dropdown: {size: size}).to generate html
    end
  end
end

shared_examples_for 'the :layout dropdown option' do
  Bh::Button.layouts.each do |layout, layout_class|
    specify %Q{set to :#{layout}, adds the class "#{layout_class}"} do
      html = %r{<button class="dropdown-toggle btn btn-default #{layout_class}"}
      expect(dropdown: {layout: layout}).to generate html
    end
  end
end

shared_examples_for 'the :groupable dropdown option' do
  Bh::Dropdown.groupables.each do |groupable, groupable_class|
    specify %Q{set to :#{groupable}, adds the class "#{groupable_class}"} do
      html = %r{^<div class="#{groupable_class}">}
      expect(dropdown: {groupable: groupable}).to generate html
    end
  end
end

shared_examples_for 'the :direction dropdown option' do
  Bh::Dropdown.directions.each do |direction, direction_class|
    specify %Q{set to :#{direction}, adds the class "#{direction_class}"} do
      html = %r{^<div class="btn-group #{direction_class}">}
      expect(dropdown: {direction: direction}).to generate html
    end
  end
end

shared_examples_for 'the :align dropdown option' do
  Bh::Dropdown.aligns.each do |align, align_class|
    specify %Q{set to :#{align}, adds the class "#{align_class}"} do
      html = %r{<ul class="dropdown-menu #{align_class}" role="menu"}
      expect(dropdown: {align: align}).to generate html
    end
  end
end

shared_examples_for 'the :split dropdown option' do
  html = %r{<button type="button" class="btn btn-default">caption</button>}

  specify %Q{set to truthy, splits the caption and the caret} do
    expect(dropdown: {split: true}).to generate html
  end

  specify %Q{set to falsey, does not split the caption and the caret} do
    expect(dropdown: {split: false}).not_to generate html
  end
end

shared_examples_for 'the button: :class dropdown option' do
  specify 'appends the class to the modal button' do
    html = %r{<button class="dropdown-toggle important btn btn-default"}
    expect(dropdown: {button: {class: 'important'}}).to generate html
  end
end
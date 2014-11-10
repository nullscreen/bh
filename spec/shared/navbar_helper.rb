shared_examples_for 'the navbar helper' do
  all_tests_pass_with 'no navbar options'
  all_tests_pass_with 'the :fluid navbar option'
  all_tests_pass_with 'the :inverted navbar option'
  all_tests_pass_with 'the :position navbar option'
  all_tests_pass_with 'the :padding navbar option'
end

#--

shared_examples_for 'no navbar options' do
  specify 'creates a <nav> element with a nested container' do
    html = <<-EOT.strip_heredoc.strip
      <nav class="navbar navbar-default" role="navigation">
        <div class="container">
          content
        </div>
      </nav>
    EOT
    expect(:navbar).to generate html
  end
end

shared_examples_for 'the :fluid navbar option' do
  Bh::Navbar.layouts.each do |value, fluid_class|
    specify %Q{set to #{value}, sets the class "#{fluid_class}"} do
      html = %r{<div class="#{fluid_class}">}
      expect(navbar: {fluid: value}).to generate html
    end
  end
end

shared_examples_for 'the :inverted navbar option' do
  Bh::Navbar.styles.each do |value, inverted_class|
    specify %Q{set to #{value}, sets the class "#{inverted_class}"} do
      html = %r{<nav class="navbar #{inverted_class}"}
      expect(navbar: {inverted: value}).to generate html
    end
  end
end

shared_examples_for 'the :position navbar option' do
  Bh::Navbar.positions.each do |position, position_class|
    specify %Q{set to #{position}, sets the class "#{position_class}"} do
      html = %r{<nav class="navbar navbar-default #{position_class}"}
      expect(navbar: {position: position}).to generate html
    end
  end
end

shared_examples_for 'the :padding navbar option' do
  [:top, :bottom].each do |position|
    specify %Q{set to a value, uses that value for #{position} position} do
      html = %r{<style>body {padding-#{position}: 100px}</style>}m
      expect(navbar: {position: position, padding: 100}).to generate html
    end

    specify %Q{not set, uses a default value of 70px for #{position} position} do
      html = %r{<style>body {padding-#{position}: 70px}</style>}m
      expect(navbar: {position: position}).to generate html
    end
  end
end
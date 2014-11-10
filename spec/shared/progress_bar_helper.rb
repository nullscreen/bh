shared_examples_for 'the progress_bar helper' do
  all_tests_pass_with 'no progress_bar options'
  all_tests_pass_with 'extra progress_bar container options'
  all_tests_pass_with 'extra progress_bar bar options'
  all_tests_pass_with 'the :percentage progress_bar option'
  all_tests_pass_with 'the :label progress_bar option'
  all_tests_pass_with 'the :context progress_bar option'
  all_tests_pass_with 'the :striped progress_bar option'
  all_tests_pass_with 'the :animated progress_bar option'
  all_tests_pass_with 'an array of progress_bar options'
end

#--

shared_examples_for 'no progress_bar options' do
  specify 'displays an empty progress <div>' do
    html = '<div class="progress"></div>'
    expect(:progress_bar).to generate html
  end
end

shared_examples_for 'extra progress_bar container options' do
  specify 'passes the options to the <div>' do
    options = {class: 'important', data: {value: 1}, id: 'my-progress-bars'}
    html = '<div class="important progress" data-value="1" id="my-progress-bars"></div>'
    expect(progress_bar: [nil, options]).to generate html
  end
end

shared_examples_for 'extra progress_bar bar options' do
  specify 'passes the options to the bar <div>' do
    bar = {class: 'important', data: {value: 1}, id: 'my-progress-bar'}
    html = %r{<div.*class="important progress-bar" data-value="1" id="my-progress-bar".*role="progressbar"}
    expect(progress_bar: bar).to generate html
  end
end

shared_examples_for 'the :percentage progress_bar option' do
  specify 'displays one progress bar for the given value' do
    html = '<div class="progress"><div aria-valuemax="100" aria-valuemin="0" aria-valuenow="30" class="progress-bar" role="progressbar" style="width: 30%"><span class="sr-only">30%</span></div></div>'
    expect(progress_bar: {percentage: 30}).to generate html
  end
end

shared_examples_for 'the :label progress_bar option' do
  specify 'set to false, hides the label' do
    html = %r{<div.+><span class="sr-only">30%<\/span>}
    expect(progress_bar: {percentage: 30, label: false}).to generate html
  end

  specify 'set to true, displays an auto-generated the label' do
    html = %r{<div.+>30%<\/div>}
    expect(progress_bar: {percentage: 30, label: true}).to generate html
  end

  specify 'set to a string, displays the string as the label' do
    html = %r{<div.+>Thirty<\/div>}
    expect(progress_bar: {percentage: 30, label: 'Thirty'}).to generate html
  end
end

shared_examples_for 'the :context progress_bar option' do
  Bh::ProgressBar.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %r{<div.+class="progress-bar #{context_class}"}
      expect(progress_bar: {percentage: 30, context: context}).to generate html
    end
  end
end

shared_examples_for 'the :striped progress_bar option' do
  specify 'set to false, displays a solid color bar' do
    html = %r{<div.+class="progress-bar"}
    expect(progress_bar: {percentage: 30, striped: false}).to generate html
  end

  specify 'set to true, displays a striped color bar' do
    html = %r{<div.+class="progress-bar progress-bar-striped"}
    expect(progress_bar: {percentage: 30, striped: true}).to generate html
  end
end

shared_examples_for 'the :animated progress_bar option' do
  specify 'set to false, displays a static bar' do
    html = %r{<div.+class="progress-bar"}
    expect(progress_bar: {percentage: 30, animated: false}).to generate html
  end

  specify 'set to true, displays an animated striped bar' do
    html = %r{<div.+class="progress-bar progress-bar-striped active"}
    expect(progress_bar: {percentage: 30, animated: true}).to generate html
  end
end

shared_examples_for 'an array of progress_bar options' do
  specify 'displays a group of stacked progress bars with their options' do
    bar_1 = '<div aria-valuemax="100" aria-valuemin="0" aria-valuenow="30" class="progress-bar" role="progressbar" style="width: 30%"><span class="sr-only">30%</span></div>'
    bar_2 = '<div aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" class="progress-bar" role="progressbar" style="width: 40%"><span class="sr-only">40%</span></div>'
    html = %Q{<div class="progress">#{bar_1}\n#{bar_2}</div>}
    bars = [{percentage: 30}, {percentage: 40}]
    expect(progress_bar: [bars, {}]).to generate html
  end
end
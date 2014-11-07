shared_examples_for 'the progress_bar helper' do
  require 'bh/helpers/progress_bar_helper'
  include Bh::ProgressBarHelper

  all_tests_pass_with 'no progress_bar options'
  all_tests_pass_with 'the :percentage progress_bar option'
  all_tests_pass_with 'the :label progress_bar option'
  all_tests_pass_with 'the :context progress_bar option'
  all_tests_pass_with 'the :striped progress_bar option'
  all_tests_pass_with 'the :animated progress_bar option'
  all_tests_pass_with 'extra progress_bar bar options'
  all_tests_pass_with 'an array of progress_bar options'
  all_tests_pass_with 'extra progress_bar container options'
end

#--

shared_examples_for 'no progress_bar options' do
  specify 'displays an empty progress bar' do
    expect(nil).to generate_progress_bar_with '<div class="progress"></div>'
  end
end

shared_examples_for 'the :percentage progress_bar option' do
  specify 'displays one progress bar for the given value' do
    html = '<div aria-valuemax="100" aria-valuemin="0" aria-valuenow="30" class="progress-bar" role="progressbar" style="width: 30%"><span class="sr-only">30%</span></div>'
    expect(percentage: 30).to generate_progress_bar_with html
  end
end

shared_examples_for 'the :label progress_bar option' do
  specify 'set to false, hides the label' do
    html = '<span class="sr-only">30%</span>'
    expect(percentage: 30, label: false).to generate_progress_bar_with html
  end

  specify 'set to true, displays an auto-generated the label' do
    html = '>30%</div>'
    expect(percentage: 30, label: true).to generate_progress_bar_with html
  end

  specify 'set to a string, displays the string as the label' do
    html = '>Thirty</div>'
    expect(percentage: 30, label: 'Thirty').to generate_progress_bar_with html
  end
end

shared_examples_for 'the :context progress_bar option' do
  Bh::ProgressBar.new.contexts.each do |context, context_class|
    specify %Q{set to :#{context}, adds the class "#{context_class}"} do
      html = %Q{class="progress-bar #{context_class}"}
      expect(percentage: 30, context: context).to generate_progress_bar_with html
    end
  end
end

shared_examples_for 'the :striped progress_bar option' do
  specify 'set to false, displays a solid color bar' do
    html = 'class="progress-bar"'
    expect(percentage: 30, striped: false).to generate_progress_bar_with html
  end

  specify 'set to true, displays a striped color bar' do
    html = 'class="progress-bar progress-bar-striped"'
    expect(percentage: 30, striped: true).to generate_progress_bar_with html
  end
end

shared_examples_for 'the :animated progress_bar option' do
  specify 'set to false, displays a static bar' do
    html = 'class="progress-bar"'
    expect(percentage: 30, animated: false).to generate_progress_bar_with html
  end

  specify 'set to true, displays an animated striped bar' do
    html = 'class="progress-bar progress-bar-striped active"'
    expect(percentage: 30, animated: true).to generate_progress_bar_with html
  end
end

shared_examples_for 'extra progress_bar bar options' do
  specify 'passes the options to the bar <div>' do
    html = 'class="important progress-bar" data-value="1" id="my-bar"'
    expect(class: :important, id: 'my-bar', data: {value: 1}).to generate_progress_bar_with html
  end
end

shared_examples_for 'an array of progress_bar options' do
  let(:options_1) { {percentage: 30} }
  let(:html_1) { '<div aria-valuemax="100" aria-valuemin="0" aria-valuenow="30" class="progress-bar" role="progressbar" style="width: 30%"><span class="sr-only">30%</span></div>' }
  let(:options_2) { {percentage: 40} }
  let(:html_2) { '<div aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" class="progress-bar" role="progressbar" style="width: 40%"><span class="sr-only">40%</span></div>' }

  specify 'displays a group of stacked progress bars with their options' do
    html = "#{html_1}\n#{html_2}"
    expect([options_1, options_2]).to generate_progress_bar_with html
  end
end

shared_examples_for 'extra progress_bar container options' do
  let(:html) { progress_bar({percentage: 30}, class: :important, id: 'my-container') }

  specify 'passes the options to the bar <div>' do
    expect(html).to match '<div class="important progress" id="my-container"><div.+</div></div>'
  end
end

#--

RSpec::Matchers.define :generate_progress_bar_with do |html|
  match do |options|
    progress_bar(*[options].compact).include? html
  end
end
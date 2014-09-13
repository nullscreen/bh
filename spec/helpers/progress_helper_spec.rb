require 'spec_helper'
require 'bh/helpers/progress_helper'
include Bh::ProgressHelper

describe 'progress' do
  specify 'given a value it renders the default wrapper class' do
    expect(progress value: 42).to include 'class="progress"'
  end

  specify 'given a value it renders value attribute' do
    expect(progress value: 42).to include 'aria-valuenow="42"'
  end

  specify 'given a value it renders width styling property' do
    expect(progress value: 42).to include 'style="width: 42%;"'
  end

  specify 'given a value and max option it renders max attribute' do
    expect(progress value: 42, max: 110).to include 'aria-valuemax="110"'
  end

  specify 'given a value and min option it renders min attribute' do
    expect(progress value: 42, min: 10).to include 'aria-valuemin="10"'
  end

  specify 'given a value it renders default inner class' do
    expect(progress value: 42).to include 'class="progress-bar progress-bar-default"'
  end

  specify 'given a value it renders role attribute' do
    expect(progress value: 42).to include 'role="progressbar"'
  end

  specify 'given a value and a context option it renders with context class' do
    expect(progress value: 42, context: :info).to include 'class="progress-bar progress-bar-info"'
  end

  specify 'given a value and a label it renders label' do
    expect(progress value: 42, label: '42% complete').to include '<span>42% complete</span>'
  end

  specify 'given a value and a sr_label option it renders sr-only span element' do
    expect(progress value: 42, sr_label: '42% complete sr').to include '<span class="sr-only"> 42% complete sr</span>'
  end

  specify 'given a value and an active options which is non blank it renders active class' do
    expect(progress value: 42, active: true).to include 'active'
  end

  specify 'given a value and an striped options which is non blank it renders striped class' do
    expect(progress value: 42, striped: true).to include 'progress-bar-striped'
  end

  specify 'given no value in hash it raises ArgumentError' do
    expect { progress({}) }.to raise_error ArgumentError, 'value must be set in argument hash'
  end

  describe 'given an array of hashes' do
    specify 'with different options it renders each as a stacked progress bar' do
      array_of_options = [{
        value: 73,
        context: :info
      }, {
        value: 21,
        context: :success
      }]    
      progress_stacked = progress array_of_options
      expect(progress_stacked).to include 'class="progress-bar progress-bar-info"'
      expect(progress_stacked).to include 'aria-valuenow="21"'
      expect(progress_stacked).to include 'class="progress-bar progress-bar-success"'
      expect(progress_stacked).to include 'aria-valuenow="73"'
    end
  end
end

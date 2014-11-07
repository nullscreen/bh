# encoding: UTF-8

require 'spec_helper'
require 'bh/helpers/progress_bar_helper'

include Bh::ProgressBarHelper

describe 'progress_bar' do
  attr_accessor :output_buffer

  context 'without options' do
    let(:html) { progress_bar }

    it 'displays an empty progress bar' do
      expect(html).to include '<div class="progress">'
    end
  end

  context 'with a hash of options' do
    let(:html) { progress_bar options.merge(percentage: 30) }
    let(:options) { {} }

    it 'displays one progress bar for the given value' do
      expect(html).to include '<div aria-valuemax="100" aria-valuemin="0" aria-valuenow="30" class="progress-bar" role="progressbar" style="width: 30%">'
    end

    describe 'given the :label option' do
      specify 'is not set, hides the label' do
        expect(html).to include '<span class="sr-only">30%</span>'
      end

      context 'is set to false, hides the label' do
        let(:options) { {label: false }}
        it { expect(html).to include '<span class="sr-only">30%</span>' }
      end

      context 'is set to true, displays a label matching the percentage' do
        let(:options) { {label: true }}
        it { expect(html).to include '30%</div>' }
      end

      context 'is a string, displays the string as the label' do
        let(:options) { {label: "Thirty percent" }}
        it { expect(html).to include 'Thirty percent</div>' }
      end
    end

    describe 'given the :context option' do
      specify 'is not set, shows a default bar' do
        expect(html).to include 'class="progress-bar"'
      end

      context 'is set to :success, shows a "success" bar' do
        let(:options) { {context: :success} }
        it { expect(html).to include 'class="progress-bar progress-bar-success"' }
      end

      context 'is set to :info, shows a "info" bar' do
        let(:options) { {context: :info} }
        it { expect(html).to include 'class="progress-bar progress-bar-info"' }
      end

      context 'is set to :warning, shows a "warning" bar' do
        let(:options) { {context: :warning} }
        it { expect(html).to include 'class="progress-bar progress-bar-warning"' }
      end

      context 'is set to :danger, shows a "danger" bar' do
        let(:options) { {context: :danger} }
        it { expect(html).to include 'class="progress-bar progress-bar-danger"' }
      end
    end

    describe 'given the :striped option' do
      specify 'is not set, shows a solid color bar' do
        expect(html).to include 'class="progress-bar"'
      end

      context 'is set to false, shows a solid color bar' do
        let(:options) { {striped: false} }
        it { expect(html).to include 'class="progress-bar"' }
      end

      context 'is set to true, shows a striped color bar' do
        let(:options) { {striped: true} }
        it { expect(html).to include 'class="progress-bar progress-bar-striped"' }
      end
    end

    describe 'given the :animated option' do
      specify 'is not set, shows a static color bar' do
        expect(html).to include 'class="progress-bar"'
      end

      context 'is set to false, shows a static color bar' do
        let(:options) { {animated: false} }
        it { expect(html).to include 'class="progress-bar"' }
      end

      context 'is set to true, shows an animated color bar' do
        let(:options) { {animated: true} }
        it { expect(html).to include 'class="progress-bar progress-bar-striped active"' }
      end
    end

    describe 'given extra options' do
      let(:options) { {class: :important, id: 'my-bar', data: {value: 1}} }
      specify 'passes the options to the progress bar <div>' do
        expect(html).to include 'class="important progress-bar" data-value="1" id="my-bar"'
      end
    end
  end

  context 'with an array of options' do
    let(:html) { progress_bar [options_bar_1, options_bar_2] }
    let(:options_bar_1) { {percentage: 20, context: :success, label: true} }
    let(:options_bar_2) { {percentage: 30, animated: true, label: 'Current'} }

    it 'displays a group of stacked progress bars with their options' do
      expect(html).to match %r{^<div class="progress"><div.+aria-valuenow="20" class="progress-bar progress-bar-success".+style="width: 20%">20% \(success\)</div>\n<div.+aria-valuenow="30" class="progress-bar progress-bar-striped active".+style="width: 30%">Current</div></div>$}m
    end
  end

  context 'with progress bar options and extra options' do
    let(:html) { progress_bar({percentage: 30}, class: :important, id: 'my-container') }

    it 'passes the extra options to the wrapping container' do
      expect(html).to match '<div class="important progress" id="my-container"><div.+</div></div>'
    end
  end
end
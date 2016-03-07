require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'bh'

Dir['./spec/shared/**/*.rb'].each {|f| require f}
require './spec/support/matchers.rb'
require './spec/support/padrino.rb' unless ENV['ONLY_RAILS']
require './spec/support/rails.rb'

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false
  config.alias_it_should_behave_like_to :all_tests_pass_for, ''
  config.alias_it_should_behave_like_to :all_tests_pass_with, 'with'
end
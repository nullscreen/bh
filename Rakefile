require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'rspec/core/version'

desc 'Run all examples'
RSpec::Core::RakeTask.new :spec

task default: [:spec]
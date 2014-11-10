require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

Dir['./spec/shared/**/*.rb'].each {|f| require f}
Dir['./spec/support/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false
  config.alias_it_should_behave_like_to :all_tests_pass_for, ''
  config.alias_it_should_behave_like_to :all_tests_pass_with, 'with'
end



class User
  require 'active_model'

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name

  def initialize(attributes = {})
    @name = attributes[:name]
  end

  def persisted?
    false
  end
end

require 'action_view'
include ActionView::Helpers::FormOptionsHelper
if defined?(ActionView::VERSION) # only defined in ActionView >=4
  include ActionView::RecordIdentifier
else
  include ActionController::RecordIdentifier
end
I18n.enforce_available_locales = true

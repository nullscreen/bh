require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

Dir['./spec/support/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false
end

class User
  require 'active_model'
  require 'active_support/all'

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

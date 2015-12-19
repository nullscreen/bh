require 'spec_helper'

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
include defined?(ActionView::VERSION) ? ActionView::RecordIdentifier : ActionController::RecordIdentifier
I18n.enforce_available_locales = true

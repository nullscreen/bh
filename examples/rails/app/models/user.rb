class User
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :password, :remember_me, :phone, :subscribe, :avatar

  def persisted?
    true
  end

  def id
    2
  end
end
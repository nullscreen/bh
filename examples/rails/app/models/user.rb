class User
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def persisted?
    true
  end

  def id
    2
  end
end
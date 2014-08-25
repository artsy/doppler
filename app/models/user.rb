class User
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :name, :email, :access_token

  def attributes
    {
      id: id,
      name: name,
      email: email,
      access_token: access_token
    }
  end
end

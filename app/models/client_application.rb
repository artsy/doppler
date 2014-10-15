class ClientApplication
  include ActiveModel::Model

  attr_accessor :id, :name, :client_id, :client_secret, :enabled, :published_artworks_access_enabled, :created_at, :updated_at

  def persisted?
    !id.nil?
  end
end

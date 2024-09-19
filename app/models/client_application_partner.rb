class ClientApplicationPartner
  include ActiveModel::Model

  attr_accessor :id, :client_application_name, :client_application_id, :partner_id, :partner_name, :created_at, :updated_at
end

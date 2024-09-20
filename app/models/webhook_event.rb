class WebhookEvent
  include ActiveModel::Model

  attr_accessor :id, :name, :created_at, :data, :partner_id
end

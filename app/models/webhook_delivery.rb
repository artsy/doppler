class WebhookDelivery
  include ActiveModel::Model

  attr_accessor :id, :response_status, :error_class, :created_at, :completed_at, :webhook_event, :webhook_id, :webhook_url

  def initialize(attributes = {})
    super
    if attributes[:webhook_event].present?
      self.webhook_event = WebhookEvent.new(attributes[:webhook_event])
    end
  end
end

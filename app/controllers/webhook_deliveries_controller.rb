class WebhookDeliveriesController < ApplicationController
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    client_application_id = params[:client_application_id]
    url = "#{Gravity::GRAVITY_V1_API_URL}/webhook_deliveries"
    response = Gravity.get(url: url, additional_headers: {"X-Access-Token": session[:access_token]}, params: {client_application_id: "4f27b387-0879-4dab-a032-5718e8054188", page: page, size: per_page})

    @webhook_deliveries = response.map do |webhook_delivery_data|
      build_webhook_delivery(webhook_delivery_data)
    end

    @total_pages = 10 # FIX ME: response.headers["X-Total-Count"]
    @current_page = page.to_i
  end

  private

  def build_webhook_delivery(data)
    WebhookDelivery.new(
      id: data[:id],
      response_status: data[:response_status],
      error_class: data[:error_class],
      created_at: data[:created_at],
      completed_at: data[:completed_at],
      webhook_event: data[:webhook_event]
    )
  end

  def client_application_partner_params
    params.require(:client_application).permit(:client_application_id)
  end
end

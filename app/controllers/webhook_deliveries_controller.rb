class WebhookDeliveriesController < ApplicationController
  def index
    page = params[:page] || 1
    size = params[:size] || 10
    client_application_id = params[:client_application_id]

    response = ClientApplicationService.fetch_webhook_deliveries(
      session[:access_token],
      client_application_id: client_application_id, page: page, size: size
    )

    @webhook_deliveries = response.map do |webhook_delivery_data|
      build_webhook_delivery(webhook_delivery_data)
    end

    @total_pages = 1 # FIX ME: response.headers["X-Total-Count"]
    @current_page = page.to_i
  rescue => e
    @error = e.message
  end

  def show
    # TODO: unstub
    @webhook_delivery = {"id" => "210e2eb8-af39-495f-baba-ca589860ea07",
                         "created_at" => "2024-10-03T15:57:47.767Z",
                         "completed_at" => "2024-10-08T10:57:46.741Z",
                         "error_class" => nil,
                         "response_status" => 200,
                         "webhook_event" =>
     {"created_at" => 1728403067,
      "data" =>
       {"sales_tax" => 10.0,
        "artwork_id" => "1234",
        "list_price" => 855.35,
        "sale_price" => 755.35,
        "external_id" => "4321",
        "availability" => "sold",
        "import_source" => "somewhere",
        "price_display" => "exact",
        "shipping_costs" => 90.0},
      "id" => "a4ca6be7-2a86-4e5c-80de-988af1ae651a",
      "name" => "artwork.order.approved",
      "partner_id" => "1234"},
                         "webhook_id" => "e01cd7e5-1a03-43a5-8463-a8dad1549e2a",
                         "webhook_url" => "https://www.cool.com/endpoint"}.as_json
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

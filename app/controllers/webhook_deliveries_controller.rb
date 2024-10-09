class WebhookDeliveriesController < ApplicationController
  include Paginatable
  before_action :set_client_application_id, :set_access_token

  def index
    cache_key = "webhook_deliveries/#{@client_application_id}/page/#{@page}/size/#{@size}"

    # Use Rails.cache to cache the API response across requests
    response = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      fetch_webhook_deliveries
    end

    @webhook_deliveries = response[:body].map do |webhook_delivery_data|
      build_webhook_delivery(webhook_delivery_data)
    end

    @total_pages = calculate_total_pages(response[:headers]["X-Total-Count"].to_i, @size)
    @current_page = @page.to_i
  rescue => e
    @error = e.message
  end

  def show
    response = ClientApplicationService.fetch_webhook_delivery(
      @access_token,
      id: params[:id]
    )

    @webhook_delivery = build_webhook_delivery(response[:body])
  rescue => e
    @error = e.message
  end

  private

  def build_webhook_delivery(data)
    WebhookDelivery.new(
      id: data[:id],
      response_status: data[:response_status],
      error_class: data[:error_class],
      created_at: data[:created_at],
      completed_at: data[:completed_at],
      webhook_event: data[:webhook_event],
      webhook_id: data[:webhook_id],
      webhook_url: data[:webhook_url]
    )
  end

  def fetch_webhook_deliveries
    response = ClientApplicationService.fetch_webhook_deliveries(
      @access_token,
      client_application_id: @client_application_id,
      page: @page,
      size: @size,
      total_count: true
    )

    {body: response[:body], headers: response[:headers]}
  end

  def set_client_application_id
    @client_application_id = params[:client_application_id]
  end

  def set_access_token
    @access_token = session[:access_token]
  end

  def client_application_partner_params
    params.require(:client_application).permit(:client_application_id)
  end
end

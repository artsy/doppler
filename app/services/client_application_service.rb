class ClientApplicationService
  def self.fetch_webhook_deliveries(access_token, params = {})
    url = "#{Gravity::GRAVITY_V1_API_URL}/webhook_deliveries"
    Gravity.get(url: url, additional_headers: {"X-Access-Token" => access_token}, params: params)
  end

  def self.fetch_webhook_delivery(access_token, params = {})
    url = "#{Gravity::GRAVITY_V1_API_URL}/webhook_delivery/#{params[:id]}"
    Gravity.get(url: url, additional_headers: {"X-Access-Token" => access_token}, params: params)
  end

  def self.redeliver_webhook_delivery(access_token, params = {})
    url = "#{Gravity::GRAVITY_V1_API_URL}/webhook_delivery/#{params[:id]}/redeliver"
    Gravity.post(url: url, additional_headers: {"X-Access-Token" => access_token}, params: params)
  end
end

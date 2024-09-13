class ClientApplicationPartnerService
  def self.fetch_partners(client_application_id, access_token)
    url = "#{Gravity::GRAVITY_V1_API_URL}/client_application/#{client_application_id}/client_application_partners"
    Gravity.get(url: url, additional_headers: {"X-Access-Token" => access_token})
  end
end

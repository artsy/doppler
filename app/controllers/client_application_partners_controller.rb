class ClientApplicationPartnersController < ApplicationController
  def new
    @client_application_partner = ClientApplicationPartner.new
  end

  def index
    url = "#{Gravity::GRAVITY_V1_API_URL}/client_application/c11d3426-b114-422e-8228-05be9bfb6f21/client_application_partners"
    response = Gravity.get(url: url, additional_headers: {"X-Access-Token" => session[:access_token]})

    # Convert each response hash into a ClientApplicationPartner object
    @client_application_partners = response.map do |partner_data|
      ClientApplicationPartner.new(
        id: partner_data[:id],
        partner_id: partner_data[:partner_id],
        client_application_id: partner_data[:client_application_id],
        created_at: partner_data[:created_at],
        updated_at: partner_data[:updated_at]
      )
    end
  rescue => e
    @error = e.message
  end


end

class ClientApplicationPartnersController < ApplicationController
  def index
    client_application_id = params[:client_application_id]
    response = ClientApplicationPartnerService.fetch_partners(client_application_id, session[:access_token])

    # Convert each response hash into a ClientApplicationPartner object
    @client_application_partners = response.map do |partner_data|
      build_client_application_partner(partner_data)
    end
  rescue => e
    @error = e.message
  end

  private

  def build_client_application_partner(data)
    ClientApplicationPartner.new(
      id: data[:id],
      partner_id: data[:partner_id],
      client_application_id: data[:client_application_id],
      created_at: data[:created_at],
      updated_at: data[:updated_at]
    )
  end

  def client_application_partner_params
    params.require(:client_application_partner).permit(:client_application_id, :partner_id)
  end
end

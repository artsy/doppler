class ClientApplicationPartnersController < ApplicationController
  include Paginatable
  def index
    client_application_id = params[:client_application_id]
    response = ClientApplicationPartnerService.fetch_partners(client_application_id, session[:access_token])

    @client_application_partners = response[:body].map do |partner_data|
      build_client_application_partner(partner_data)
    end

    @total_pages = calculate_total_pages(response[:headers]["X-Total-Count"].to_i, @size)
    @current_page = @page.to_i
  rescue => e
    @error = e.message
  end

  private

  def build_client_application_partner(data)
    ClientApplicationPartner.new(
      id: data[:id],
      partner_id: data[:partner_id],
      partner_name: data[:partner_name],
      client_application_id: data[:client_application_id],
      client_application_name: data[:client_application_name],
      created_at: data[:created_at],
      updated_at: data[:updated_at]
    )
  end

  def client_application_partner_params
    params.require(:client_application_partner).permit(:client_application_id, :partner_id)
  end
end

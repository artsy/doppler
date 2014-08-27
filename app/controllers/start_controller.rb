class StartController < ApplicationController
  def show
    return unless authenticated?
    @client_applications = artsy_client.links.applications.embedded.applications
    @selected_client_application = @client_applications.find { |app| app.attributes.id == params[:id] } if params.key?(:id)
    @selected_client_application ||= @client_applications.first if @client_applications.count == 1
  end
end

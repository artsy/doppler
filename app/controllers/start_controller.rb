class StartController < ApplicationController
  def show
    return unless authenticated?
    @client_applications = artsy_client.try(:applications) || []
    @selected_client_application = @client_applications.find { |app| app.id == params[:id] } if params.key?(:id)
    @selected_client_application ||= @client_applications.first if @client_applications.count == 1
  rescue => e
    @error = e
  end
end

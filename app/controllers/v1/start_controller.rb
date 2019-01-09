module V1
  class StartController < ApplicationController
    def show
      return unless authenticated?

      @client_applications = artsy_client.try(:applications) || []

      # the UI needs to ask the user to create an app, then an admin needs to enable it for v1
      # so we only display v1 apps in case there's at least one
      @client_applications_v1 = @client_applications.to_a.select { |ca| ca.api_version == 1 }
      @client_applications = @client_applications_v1 if @client_applications_v1.any?

      @selected_client_application = @client_applications.find { |app| app.id == params[:id] } if params.key?(:id)
      @selected_client_application ||= @client_applications.first if @client_applications.count == 1
      no_cache! if @selected_client_application
    rescue StandardError => e
      @error = e
    end
  end
end

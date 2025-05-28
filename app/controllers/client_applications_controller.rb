class ClientApplicationsController < ApplicationController
  include OpenRedirectHelper

  before_action :fetch_client_application, only: %i[show edit destroy update]
  before_action :no_cache!, except: [:index]
  before_action :parse_redirect_uris, only: %i[update]

  def show
  end

  def update
    @client_application._put(**client_application_params.to_h)
    fetch_client_application
    render :show
  end

  def index
    @client_applications = artsy_client.applications
  rescue => e
    @error = e.message
  end

  def destroy
    @client_application._delete
    redirect_to client_applications_path
  end

  private

  def fetch_client_application
    @client_application = artsy_client.application(id: params[:id])
    return if @client_application

    flash[:error] = "Invalid application."
    redirect_to client_applications_path
  end

  def parse_redirect_uris
    return unless client_application_params[:redirect_urls]

    client_application_params[:redirect_urls] = client_application_params[:redirect_urls].split.compact.uniq
  end

  def client_application_params
    @client_application_params ||= params.require(:client_application).permit(:name, :redirect_urls, :redirect_uri)
  end
end

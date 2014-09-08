class ClientApplicationsController < ApplicationController
  before_action :authenticate!
  before_action :fetch_client_application, only: [:show, :edit, :destroy, :update]

  def new
    @client_application = ClientApplication.new
  end

  def show
  end

  def create
    redirect_uri = params[:client_application].delete(:redirect_uri)
    response = artsy_client.links.applications.post(params[:client_application])
    flash.now[:error] = nil
    flash.now[:notice] = 'Application created!'
    redirect_uri += "?id=#{response.body['id']}" if response && redirect_uri
    redirect_to redirect_uri || client_applications_path
  end

  def update
    @client_application.put(params[:client_application])
    fetch_client_application
    render :show
  end

  def index
    @client_applications = artsy_client.links.applications.embedded.applications
  rescue => e
    @error = e.message
  end

  def destroy
    @client_application.delete
    redirect_to client_applications_path
  end

  private

  def fetch_client_application
    @client_application = artsy_client.links.application.expand(id: params[:id]).resource
    unless @client_application
      flash[:error] = 'Invalid application.'
      redirect_to client_applications_path
    end
  end
end

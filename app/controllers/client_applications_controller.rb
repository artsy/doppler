class ClientApplicationsController < ApplicationController
  include OpenRedirectHelper

  before_action :authenticate!
  before_action :fetch_client_application, only: [:show, :edit, :destroy, :update]
  before_action :no_cache!, except: [:index]

  def new
    @client_application = ClientApplication.new
  end

  def show
  end

  def create
    redirect_uri = safe_redirect_uri(params[:client_application].delete(:redirect_uri))
    @client_application = artsy_client.applications._post(params[:client_application])
    flash.now[:error] = nil
    flash.now[:notice] = 'Application created!'
    redirect_uri += "?id=#{@client_application.id}" if @client_application && !redirect_uri.blank?
    redirect_uri = client_applications_path if redirect_uri.blank?
    redirect_to redirect_uri
  end

  def update
    @client_application._put(params[:client_application])
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
    flash[:error] = 'Invalid application.'
    redirect_to client_applications_path
  end
end

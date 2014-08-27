class ApplicationController < ActionController::Base
  include WardenHelper
  protect_from_forgery with: :exception

  def authenticate!
    return if authenticated?
    redirect_uri = params[:redirect_uri]
    if redirect_uri
      redirect_to "/auth/artsy?redirect_uri=#{CGI.escape(redirect_uri)}"
    else
      redirect_to '/auth/artsy'
    end
  end

  def artsy_client
    @client ||= ArtsyAPI.client(access_token: current_user.try(:access_token))
  end
end

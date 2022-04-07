class ApplicationController < ActionController::Base
  include WardenHelper
  include CacheHelper
  protect_from_forgery with: :exception
  before_action :set_raven_context

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
    @client ||= if authenticated?
                  ArtsyAPI::V2.client(access_token: current_user.try(:access_token))
                else
                  ArtsyAPI::V2.client(xapp_token: ArtsyAPI::V2.xapp_token)
    end
  end

  def set_raven_context
    return unless authenticated?

    Raven.user_context(
      id: current_user.id,
      username: current_user.name,
      email: current_user.email
    )
  end
end

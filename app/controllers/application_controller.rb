class ApplicationController < ActionController::Base
  include CacheHelper
  include ArtsyAuth::Authenticated

  protect_from_forgery with: :exception
  before_action :set_raven_context
  helper_method :authenticated?

  def artsy_client
    @client ||= if authenticated?
                  ArtsyAPI::V2.client(access_token: session[:access_token])
                else
                  ArtsyAPI::V2.client(xapp_token: ArtsyAPI::V2.xapp_token)
    end
  end

  def set_raven_context
    return unless authenticated?

    Raven.user_context(
      id: session[:user_id],
      email: session[:email]
    )
  end

  def authenticated?
    session[:user_id].present?
  end

  def authorized_artsy_token?(token)
    JWT.decode(token, ENV['JWT_SECRET'])
  end
end

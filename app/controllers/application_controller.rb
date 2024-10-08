class ApplicationController < ActionController::Base
  include CacheHelper
  include ArtsyAuth::Authenticated

  protect_from_forgery with: :exception
  before_action :set_sentry_context
  helper_method :authenticated?

  def artsy_client
    @client ||= if authenticated?
      ArtsyApi::V2.client(access_token: session[:access_token])
    else
      ArtsyApi::V2.client(xapp_token: ArtsyApi::V2.xapp_token)
    end
  end

  def set_sentry_context
    return unless authenticated?

    Sentry.set_user(user_id: session[:user_id], email: session[:email])
  end

  def authenticated?
    session[:user_id].present?
  end

  def authorized_artsy_token?(token)
    JWT.decode(token, ENV["JWT_SECRET"])
  end
end

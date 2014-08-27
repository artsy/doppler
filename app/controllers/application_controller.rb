class ApplicationController < ActionController::Base
  include WardenHelper
  protect_from_forgery with: :exception

  def authenticate!
    redirect_to '/auth/artsy' unless authenticated?
  end

  def artsy_client
    @client ||= ArtsyAPI.client(current_user.try(:access_token))
  end
end

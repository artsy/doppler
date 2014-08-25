class ApplicationController < ActionController::Base
  include WardenHelper
  protect_from_forgery with: :exception

  def authenticate!
    redirect_to '/auth/artsy' unless authenticated?
  end
end

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
    if authenticated?
      @client ||= ArtsyAPI.client(access_token: current_user.try(:access_token))
    else
      @client ||= ArtsyAPI.client(xapp_token: xapp_token)
    end
  end

  private

  def xapp_token
    Rails.cache.fetch "xapp-token/#{ENV['ARTSY_API_CLIENT_ID']}", expires_in: 1.hour do
      response = Net::HTTP.post_form(URI.parse("#{ArtsyAPI.artsy_api_root}/tokens/xapp_token"),
                                     client_id: ENV['ARTSY_API_CLIENT_ID'],
                                     client_secret: ENV['ARTSY_API_CLIENT_SECRET']
      )
      xapp_response = JSON.parse(response.body)
      fail xapp_response['message'] || 'Unknown Error' if response.code != '201'
      xapp_response['token']
    end
  end
end

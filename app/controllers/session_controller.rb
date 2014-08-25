class SessionController < ApplicationController
  def new
    authenticate!
  end

  def create
    user = User.new(
      id: auth_hash.try(:uid),
      name: auth_hash.try(:info).try(:raw_info).try(:name),
      email: auth_hash.try(:info).try(:raw_info).try(:email),
      access_token: auth_hash.try(:credentials).try(:token)
    )
    warden.set_user user
    redirect_to '/'
  end

  def destroy
    warden.logout
    artsy_api_url = ENV['ARTSY_API_URL'] || 'http://localhost:3000'
    redirect_to "#{artsy_api_url}/users/sign_out?redirect_uri=#{CGI.escape(request.url.gsub('/sign_out', '/'))}"
  end

  protected

  def auth_hash
    @auth_hash ||= Hashie::Mash.new(request.env['omniauth.auth'])
  end
end

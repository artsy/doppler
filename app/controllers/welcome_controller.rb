class WelcomeController < ApplicationController
  def index
    @public_artworks_count = Rails.cache.fetch "public_artworks_count/#{ENV['ARTSY_API_CLIENT_ID']}", expires_in: 12.hours do
      ArtsyAPI.public_artworks_count('X-XAPP-Token' => xapp_token)
    end
  end
end

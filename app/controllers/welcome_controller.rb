class WelcomeController < ApplicationController
  def index
    @artworks_count = Rails.cache.fetch "artworks_count/#{ENV['ARTSY_API_CLIENT_ID']}", expires_in: 12.hours do
      ArtsyAPI.artworks_count
    end
  rescue
    # ignore
  end
end

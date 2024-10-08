class WelcomeController < ApplicationController
  skip_before_action :require_artsy_authentication

  def index
    @artworks_count = Rails.cache.fetch "artworks_count/#{ENV["ARTSY_API_CLIENT_ID"]}", expires_in: 12.hours do
      ArtsyApi::V2.artworks_count
    end
  rescue
    # ignore
  end
end

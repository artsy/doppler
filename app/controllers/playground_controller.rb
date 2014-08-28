class PlaygroundController < ApplicationController
  before_action :authenticate!

  def index
    @options = {
      access_token: current_user.access_token,
      api_docs_url: ArtsyAPI.artsy_api_docs_url
    }
  end
end

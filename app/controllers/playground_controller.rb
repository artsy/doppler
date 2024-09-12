class PlaygroundController < ApplicationController
  before_action :no_cache!

  def index
    @options = case request.env["PATH_INFO"]
    when "/v1/playground" then options_v1
    when "/v2/playground" then options_v2
    end
  end

  private

  def options_v2
    {
      access_token: session[:access_token],
      api_docs_url: ArtsyApi::V2.docs_url
    }
  end

  def options_v1
    {
      access_token: session[:access_token],
      api_docs_url: ArtsyApi::V1.docs_url
    }
  end
end

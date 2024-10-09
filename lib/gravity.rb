# API Client for Gravity V1
class Gravity
  GRAVITY_V1_API_URL = Rails.application.config_for(:gravity)["api_v1_root"]

  class << self
    class GravityError < StandardError; end

    class GravityNotFoundError < GravityError; end

    def get(url:, additional_headers: {}, params: {})
      response = Faraday.get(url, params, headers.merge(additional_headers))

      process(response)
    end

    def process(response)
      raise GravityNotFoundError if response.status == 404

      results = JSON.parse(response.body, symbolize_names: true)
      raise GravityError, "Couldn't perform request! status: #{response.status}. Message: #{results[:message]}" unless response.success?

      # Return both the body and only the `X-Total-Count` header part of the response
      {body: results, headers: {"X-Total-Count" => response.headers["X-Total-Count"]}}
    end

    private

    def headers
      {}
    end
  end
end

# API Client for Gravity V1
class Gravity
  class << self
    GRAVITY_V1_API_URL = Rails.application.config_for(:gravity)["api_v1_root"]

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

      results
    end

    private

    def headers
      {}
    end
  end
end

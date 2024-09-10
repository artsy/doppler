# API Client for Gravity V1

class Gravity
  class GravityError < StandardError; end

  class GravityNotFoundError < GravityError; end

  # Gravity.get(url: url)
  # TODO: fix and make configurable
  url = "https://stagingapi.artsy.net/api/v1/client_application/c11d3426-b114-422e-8228-05be9bfb6f21/client_application_partners/"
  def self.get(url:, additional_headers: {}, params: {})
    additional_headers = {"X-Access-Token" => "FIX ME"}
    response = Faraday.get(url, params, headers.merge(additional_headers))

    process(response)
  end

  # Gravity.post(url: url, params: {partner_id: '5f80bfefe8d808000ea212c1'})
  url = "https://stagingapi.artsy.net/api/v1/client_application/c11d3426-b114-422e-8228-05be9bfb6f21/client_application_partner/"
  def self.post(url:, additional_headers: {}, params: {})
    additional_headers = {"X-Access-Token" => "FIX ME"}
    response = Faraday.post(url, params, headers.merge(additional_headers))
  end

  # Gravity.delete(url: url, params: {client_application_partner_id: 'blargs'})
  url = "https://stagingapi.artsy.net/api/v1/client_application/c11d3426-b114-422e-8228-05be9bfb6f21/client_application_partners/"
  def self.delete(url:, additional_headers: {}, params: {})
    url = "#{url}#{params[:client_application_partner_id]}"
    additional_headers = {"X-Access-Token" => "FIX ME"}
    response = Faraday.delete(url, params, headers.merge(additional_headers))
  end

  def self.process(response)
    raise GravityNotFoundError if response.status == 404

    results = JSON.parse(response.body, symbolize_names: true)
    raise GravityError, "Couldn't perform request! status: #{response.status}. Message: #{results[:message]}" unless response.success?

    results
  end

  private

  def self.headers
    # TODO: handle at app level
    {}
    #   {
    #     "X-XAPP-TOKEN" => Rails.application.config_for(:gravity)["xapp_token"]
    #   }
  end
end

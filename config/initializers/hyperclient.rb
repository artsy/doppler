require "hyperclient/entry_point"

module Hyperclient
  class EntryPoint < Link
    def default_faraday_block
      lambda do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.use Faraday::Response::RaiseError
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter :net_http
      end
    end
  end
end

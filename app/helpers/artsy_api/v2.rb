module ArtsyApi
  module V2
    def self.url
      ENV["ARTSY_API_URL"] || "http://localhost:3000"
    end

    def self.root
      [url, "api"].join("/")
    end

    def self.docs_url
      [root, "docs"].join("/")
    end

    def self.client(options = {})
      Hyperclient.new(root) do |api|
        api.headers["Accept"] = "application/vnd.artsy-v2+json"
        api.headers["Content-Type"] = "application/json"
        api.headers["X-Access-Token"] = options[:access_token] if options.key?(:access_token)
        api.headers["X-Xapp-Token"] = options[:xapp_token] if options.key?(:xapp_token)
      end
    end

    def self.artworks_count
      conn = client.connection
      conn.headers["X-XAPP-Token"] = xapp_token
      conn.get("#{root}/artworks?total_count=1").body["total_count"]
    end

    def self.xapp_token
      Rails.cache.fetch "xapp-token/#{ENV["ARTSY_API_CLIENT_ID"]}", expires_in: 1.hour do
        client.tokens.xapp_token._post(client_id: ENV["ARTSY_API_CLIENT_ID"], client_secret: ENV["ARTSY_API_CLIENT_SECRET"]).token
      end
    end
  end
end

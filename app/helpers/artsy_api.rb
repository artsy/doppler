module ArtsyAPI
  def self.artsy_api_url
    ENV['ARTSY_API_URL'] || 'http://localhost:3000'
  end

  def self.artsy_api_root
    "#{artsy_api_url}/api"
  end

  def self.artsy_api_docs_url
    "#{artsy_api_root}/docs"
  end

  def self.client(options = {})
    Hyperclient.new(artsy_api_root).tap do |api|
      api.headers.update('Accept' => 'application/vnd.artsy-v2+json')
      api.headers.update('X-Access-Token' => options[:access_token]) if options.key?(:access_token)
      api.headers.update('X-Xapp-Token' => options[:xapp_token]) if options.key?(:xapp_token)
    end
  end

  def self.artworks_count
    conn = client.connection
    conn.headers['X-XAPP-Token'] = xapp_token
    conn.get("#{artsy_api_root}/artworks?total_count=1").body['total_count']
  end

  def self.xapp_token
    Rails.cache.fetch "xapp-token/#{ENV['ARTSY_API_CLIENT_ID']}", expires_in: 1.hour do
      client.connection.post("#{artsy_api_root}/tokens/xapp_token",
                             client_id: ENV['ARTSY_API_CLIENT_ID'],
                             client_secret: ENV['ARTSY_API_CLIENT_SECRET']).body['token']
    end
  end
end

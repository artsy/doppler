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

  def self.public_artworks_count(options)
    url = URI.parse("#{ArtsyAPI.artsy_api_root}/artworks?public=true&size=1&total_count=1")
    http = Net::HTTP.new url.host, url.port
    http.use_ssl = true if url.is_a?(URI::HTTPS)
    resp = http.get("#{url.path}?#{url.query}", options)
    fail "error: #{resp.code}" if resp.code != '200'
    JSON.parse(resp.body)['total_count'].to_i
  end
end

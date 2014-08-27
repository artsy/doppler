module ArtsyAPI
  def self.artsy_api_root
    artsy_api_url = ENV['ARTSY_API_URL'] || 'http://localhost:3000'
    "#{artsy_api_url}/api"
  end

  def self.artsy_api_docs_url
    "#{artsy_api_root}/docs"
  end

  def self.client(access_token = nil)
    Hyperclient.new(artsy_api_root).tap do |api|
      api.headers.update(
        'Accept' => 'application/vnd.artsy-v2+json',
        'X-Access-Token' => access_token
      )
    end
  end
end

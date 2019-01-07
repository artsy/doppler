module ArtsyAPI
  module V1
    def self.url
      ENV['ARTSY_API_URL'] || 'http://localhost:3000'
    end

    def self.root
      [url, 'api/v1'].join('/')
    end

    def self.docs_url
      [root, 'swagger_doc'].join('/')
    end
  end
end

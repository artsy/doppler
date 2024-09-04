ArtsyAuth.configure do |config|
  config.artsy_api_url = ENV["ARTSY_API_URL"]
  config.application_id = ENV["ARTSY_API_CLIENT_ID"]
  config.application_secret = ENV["ARTSY_API_CLIENT_SECRET"]
end

RSpec.configure do |config|
  config.before :all do
    # use mock oauth responses and automatic redirects for 3rd parties
    OmniAuth.config.test_mode = true
  end
end

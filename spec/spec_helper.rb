ENV["RAILS_ENV"] ||= "test"

require "spec_helper"
require File.expand_path("../config/environment", __dir__)

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  Capybara.register_driver :headless_chrome do |app|
    # Create the service with the path to chromedriver
    service = Selenium::WebDriver::Service.chrome(
      path: ENV.fetch("CHROMEDRIVER_PATH", "/usr/bin/chromedriver")
    )

    # Set up Chrome options for headless mode
    options = Selenium::WebDriver::Chrome::Options.new
    options.args << "headless"
    options.args << "disable-gpu"
    options.args << "no-sandbox"
    options.args << "disable-dev-shm-usage"

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, service: service)
  end

  Capybara.configure do |config|
    config.javascript_driver = :headless_chrome
    config.default_max_wait_time = 10
  end
end

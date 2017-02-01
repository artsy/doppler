require 'capybara/rspec'
require 'capybara/rails'

unless ENV['TRAVIS']
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
end

Capybara.default_driver = :selenium

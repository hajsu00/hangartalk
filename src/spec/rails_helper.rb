# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'factory_bot'
require 'faker'
require 'capybara/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Capybara.default_driver = :selenium_chrome_headless
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1280,1024')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  config.before(:each, type: :system, js: true) do
    driven_by :selenium_remote
    host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # for omiting indicating class name 
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include LoginModule
end

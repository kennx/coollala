ENV['RACK_ENV'] = "test"
require "SimpleCov"
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
SimpleCov.start
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")



RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
end

Capybara.app = Coollala::Application
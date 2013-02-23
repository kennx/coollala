ENV['RACK_ENV'] = "test"
require "SimpleCov"
require 'shoulda/matchers'
SimpleCov.start
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler'
Bundler.setup
require 'yaml'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)
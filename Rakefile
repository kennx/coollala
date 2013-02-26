require ::File.expand_path('../config/environment',  __FILE__)
require 'sinatra/activerecord/rake'

namespace :db do
  task :environment do
    DATABASE_ENV = ENV['RACK_ENV'] || 'development'
  end
  desc 'create Database'
  task :create => :environment do
    config = Coollala::Application::DB_CONFIG[DATABASE_ENV]
    ActiveRecord::Base.establish_connection config.merge('database' => nil)
    ActiveRecord::Base.connection.create_database config['database']
    ActiveRecord::Base.establish_connection config
  end
end

namespace :app do
  desc 'Run Application'
  task :s do
    sh "rerun thin start -p 4567"
  end
  desc 'Enter Application Console'
  task :c do
    sh 'pry -r ./config/environment.rb'
  end
end

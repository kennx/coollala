source 'http://ruby.taobao.org'

gem 'sinatra',                  '~> 1.3.0',        :require => ['sinatra/base', 'sinatra/namespace']
gem 'erubis'

gem 'mysql2'
gem 'activerecord',             '~> 3.2.12',        :require => 'active_record'
gem 'sinatra-activerecord',     '~> 1.2.1',         :require => 'sinatra/activerecord'

gem 'rack-flash3',              :require => 'rack-flash'



group :development do
  gem 'sinatra-reloader',      '~> 1.0',            :require => 'sinatra/reloader'
end

group :development do
  gem 'pry'
end

group :test do
  gem 'simplecov', :require => false
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
  gem 'autotest'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
  gem "shoulda-matchers", :require => false
end


gem 'thin'
gem 'rake'
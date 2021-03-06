require 'logger'
require File.expand_path('../boot', __FILE__)
require File.expand_path('../../config/config', __FILE__)

Dir.glob(File.join(File.expand_path('../../', __FILE__), 'lib', 'helpers', '**', '*.rb')) { |file| require file }
Dir.glob(File.join(File.expand_path('../../', __FILE__), 'lib', 'models', '**' '*.rb')) { |file| require file }
Dir.glob(File.join(File.expand_path('../../', __FILE__), 'lib', 'controllers', '**', '*.rb')) { |file| require file}



module Coollala
  class Application < Sinatra::Base

    register Sinatra::Namespace
    register Sinatra::ActiveRecordExtension
    register Sinatra::Coollala::Config
    register WillPaginate::Sinatra

    use ActiveRecord::QueryCache
    use Rack::MethodOverride
    use Rack::Session::Cookie, :key => '_coollala_session', :domain => nil, :path => '/', :secret => 'your_secret'
    use Rack::Flash, :sweep => true
    use Rack::Csrf, :raise => true

    configure :development, :test, :production do
      set :root, File.expand_path('../../', __FILE__)
      set :public_folder, settings.root + '/public'
      set :views, settings.root + '/lib/views/'
    end

    configure :development, :production do
      enable :logging
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end

    DB_CONFIG = YAML::load(File.open(File.expand_path("../../", __FILE__) + "/config/database.yml"))
    ActiveRecord::Base.establish_connection(DB_CONFIG[settings.environment.to_s])

    register Sinatra::Coollala::ApplicationControllers
    register Sinatra::Coollala::UsersController
    register Sinatra::Coollala::GroupsController
    register Sinatra::Coollala::TopicsController
    register Sinatra::Coollala::RepliesController

    helpers Sinatra::Coollala::RenderHelpers
    helpers Sinatra::Coollala::TagsHelpers
    helpers Sinatra::Coollala::ApplicationHelpers
    helpers Sinatra::Coollala::TimesHelpers
    helpers Sinatra::Coollala::UsersHelpers


  end
end
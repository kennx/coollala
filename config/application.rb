require 'logger'
require File.expand_path('../boot', __FILE__)
require File.expand_path('../../config/config', __FILE__)

Dir.glob(File.join(File.expand_path('../../', __FILE__), 'lib', 'helpers', '**', '*.rb')) { |file| require file }
Dir.glob(File.join(File.expand_path('../../', __FILE__), 'lib', 'models', '**' '*.rb')) { |file| require file }
Dir.glob(File.join(File.expand_path('../../', __FILE__), 'lib', 'controllers', '**', '*.rb')) { |file| require file }

module Coollala
  class Application < Sinatra::Base

    register Sinatra::Namespace
    register Sinatra::ActiveRecordExtension
    register Sinatra::Coollala::Controllers
    register Sinatra::Coollala::Config

    use Rack::MethodOverride

    configure :development, :test, :production do
      set :root, File.expand_path('../../', __FILE__)
      set :public_folder, settings.root + '/public'
      set :views, settings.root + '/lib/views/'
    end

    configure :development, :production do
      enable :logging
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end

    configure :development do
      register Sinatra::Reloader
      Dir.glob(File.expand_path('../../', __FILE__) + '/lib/helpers/**/*.rb') { |file| also_reload file }
      Dir.glob(File.expand_path('../../', __FILE__) + '/lib/models/**/*.rb') { |file| also_reload file }
      Dir.glob(File.expand_path('../../', __FILE__) + '/lib/controllers/**/*.rb') { |file| also_reload file }
    end

    DB_CONFIG = YAML::load(File.open(File.expand_path("../../", __FILE__) + "/config/database.yml"))
    ActiveRecord::Base.establish_connection(DB_CONFIG[settings.environment.to_s])


    helpers Sinatra::Coollala::RenderHelpers
    helpers Sinatra::Coollala::TagsHelpers
    helpers Sinatra::Coollala::ApplicationHelpers
    helpers Sinatra::Coollala::TimesHelpers
  end
end




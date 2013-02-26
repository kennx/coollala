# encoding: utf-8
module Sinatra
  module Coollala
    module ApplicationControllers
      def self.registered(app)
        app.error 400..403 do
          "请求发生错误.Sorry..."
        end
        app.not_found do
          "404错误"
        end
        app.after do
          ActiveRecord::Base.clear_active_connections!
        end
      end
    end
  end
  register Coollala::ApplicationControllers
end
# encoding: utf-8
module ApplicationController
  def self.included(app)
    app.error 400..403 do
      "请求发生错误.Sorry..."
    end
    app.not_found do
      "404错误"
    end
  end
end;
module UsersController
  ;
end;

module Sinatra
  module Coollala
    module Controllers
      def self.registered(base)
        base.send :include, ApplicationController
        base.send :include, UsersController
      end
    end
  end
  register Coollala::Controllers
end
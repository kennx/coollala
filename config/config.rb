# encoding: utf-8
module Sinatra
  module Coollala
    module Config
      def self.registered(base)
        base.set :app_en_name, 'Coollala'
        base.set :app_cn_name, '酷拉拉'
        base.set :app_description, '酷拉拉'
        base.set :app_keywords, '酷拉拉'
        base.set :app_domain, 'www.coollala.com'
        base.set :avatar_directory, '/public/assets/images/avatars/'
      end
    end
  end
  register Coollala::Config
end
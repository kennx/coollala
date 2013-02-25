require 'base64'
module Sinatra
  module Coollala
    module UsersHelpers

      def signed_in(user)
        session[:user_token] = Base64.encode64(user.salt)
        self.current_user=user
      end

      def current_user?(user)
        user == current_user
      end

      def current_user
        if session[:user_token]
          @current_user ||= User.find_by_salt(Base64.decode64(session[:user_token]))
        else
          nil
        end
      end


      def current_user=(user)
        @current_user = user
      end

      def ensure_current_user(user)
        halt 401 if user != current_user
      end

      def sign_in?
        !session[:user_token].nil?
      end

      def sign_out!
        session.delete(:user_token)
        self.current_user = nil
      end

    end
  end
  helpers Coollala::UsersHelpers
end
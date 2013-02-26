module Sinatra
  module Coollala
    module UsersHelpers

      def signed_in(user)
        session[:user_token] = user.salt
        self.current_user = user
      end

      def current_user?(user)
        user == current_user
      end

      def current_user
        if session[:user_token]
          User.find_by_salt(session[:user_token])
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
        session[:user_token] = nil
        self.current_user = nil
      end

    end
  end
  helpers Coollala::UsersHelpers
end
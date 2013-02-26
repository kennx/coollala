module Sinatra
  module Coollala
    module UsersHelpers

      def signed_in(user)
        store = Coollala::SessionStore.create(:username => user.salt, :userdata => user)
        session[:user_token] = store[:data].salt
        self.current_user = store[:data]
      end

      def current_user?(user)
        user == current_user
      end

      def current_user
        if session[:user_token]
          Coollala::SessionStore.get(session[:user_token])[:data]
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
        Coollala::SessionStore.stored_data.delete(session[:user_token])
        session[:user_token] = nil
        self.current_user = nil
      end

    end
  end
  helpers Coollala::UsersHelpers
end
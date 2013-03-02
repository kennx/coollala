module Sinatra
  module Coollala
    module UsersHelpers

      def signed_in(user)
        session[:user_token] = user.auth_token
        self.current_user = user
      end

      def current_user?(user)
        user == current_user
      end

      def current_user
        if session[:user_token]
          User.find_by_auth_token(session[:user_token])
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

      def avatar_url(user)
        user.avatar
      end

      def avatar_tag(user, classname=nil)
        avatar = "/assets/images/avatars/" + avatar_url(user)
        avatar_image_tag = ''
        if classname.nil?
          avatar_image_tag = "<img src='#{avatar}' width='32' height='32' />"
        else
          avatar_image_tag = "<img src='#{avatar}' class='#{classname}'  width='32' height='32' />"
        end
        avatar_image_tag
      end

    end
  end
  helpers Coollala::UsersHelpers
end
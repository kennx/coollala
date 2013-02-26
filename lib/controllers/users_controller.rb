# encoding: utf-8
module Sinatra
  module Coollala
    module UsersController
      def self.registered(app)
        app.namespace '/admin/?' do
          before do
            if current_user.respond_to?(:is_admin?)
              halt 401 unless current_user.is_admin?
            else
              halt 401
            end
            @title = "后台管理"
          end
        end
        app.namespace '/admin/users/?' do
          get '/?' do
            @users = User.all
            @title = "用户列表"
            erb :'/users/index', :layout => :'/layout/admin'
          end
        end
        app.namespace '/admin/user/?' do
          get '/new/?' do
            @title = "新建用户1"
            erb :'/users/new', :layout => :'/layout/admin'
          end
          post '/create/?' do
            @user = User.new(params[:user])
            if @user.save
              flash[:notice] = "创建用户成功"
              redirect '/sign_in'
            else
              flash[:errors] = @user.errors.messages
              redirect back
            end
          end
          put '/:id/update/?' do
            if @user.update_attributes(params[:user])
              flash[:notice] = "更新用户成功"
              redirect '/admin/users/'
            else
              flash[:errors] = @user.errors.messages
              redirect back
            end
          end
          delete '/:id/delete/?' do
            @user.destroy
            flash[:notice] = "成功删除用户"
            redirect '/admin/users/'
          end
        end
        app.namespace '/admin/user/:id/?' do
          before do
            unless params[:id] =~ /new|edit|update|create/
              @user ||= User.find(params[:id])
            end
          end
          get '/?' do
            @title = "#{@user.name} 信息页面"
            erb :'/users/show', :layout => :'/layout/admin'
          end
          get '/edit/?' do
            @title = "编辑 #{@user.name} 信息页面"
            erb :'/users/edit', :layout => :'/layout/admin'
          end
        end
        app.get '/sign_in/?' do
          erb :'/sessions/new', :layout => :'/layout/admin'
        end
        app.put '/sign_in/?' do
          session = Session.new(params[:session])
          if session.valid? && (user = User.authentication(session.username, session.password))
            signed_in(user)
            user.after_login_update(request.ip)
            flash[:notice] = "#{session.username}登陆成功：）"
            redirect "/admin/users"
          else
            flash[:errors] = session.errors.messages || "用户名或者密码错误"
            redirect back
          end
        end
        app.delete '/sign_out/?' do
          sign_out!
          flash[:notice] = "成功退出"
          redirect '/sign_in/'
        end
      end
    end
  end
  register Coollala::UsersController
end
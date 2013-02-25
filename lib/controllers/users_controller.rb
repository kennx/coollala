# encoding: utf-8
module UsersController
  def self.included(app)
    app.namespace '/admin/?' do
      before do
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
        @title = "新建用户"
        erb :'/users/new', :layout => :'/layout/admin'
      end
      post '/create/?' do
        @user = User.new(params[:user])
        if @user.save
          redirect '/admin/user/' + @user.id.to_s
        else
          redirect back
        end
      end
      put '/:id/update/?' do
        if @user.update_attributes(params[:user])
          redirect '/admin/users/'
        else
          redirect back
        end
			end
			delete '/:id/delete/?' do
				@user.destroy
				redirect '/admin/users/'
			end
    end
    app.namespace '/admin/user/:id/?' do
      before do
        unless params[:id] =~ /new|edit|update|create/
          @user = User.find(params[:id])
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
  end
end
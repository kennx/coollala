module UsersController
  def self.included(app)
    app.namespace '/users/?' do
      get '/?' do
        @users = User.all
        render_to '/users/index', 'admin'
      end
    end
    app.namespace '/user/?' do
      get '/new/?' do
        render_to '/users/new', 'admin'
      end
      post '/create/?' do
        @user = User.create(params[:user])
        if @user
          redirect '/users/'
        else
          redirect back
        end
      end
      put '/:id/update/?' do
        if @user.update_attributes(params[:user])
          redirect '/users/'
        else
          redirect back
        end
      end
    end
    app.namespace '/user/:id/?' do
      before %r{\d?} do
        @user = User.find(params[:id])
      end
      get '/?' do
        render_to '/users/show', 'admin'
      end
      get '/edit/?' do
        render_to '/users/edit', 'admin'
      end
    end
  end
end
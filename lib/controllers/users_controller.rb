module UsersController
  def self.included(app)
    app.get '/' do
      render_to '/users/index', '/layout/admin'
    end
    app.namespace '/user/?' do
      get '/?' do
        "ddd11122"
      end
      get '/:id/?' do
        params[:id]
      end
    end
  end
end
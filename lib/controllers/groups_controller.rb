# encoding: utf-8
module Sinatra
  module Coollala
    module GroupsController
      def self.registered(app)
        app.namespace '/admin/?' do
          get '/groups/?' do
            @groups = Group.all
            erb :'/admin/groups/index', :layout => :"/layout/admin"
          end
        end
        app.namespace '/admin/group/?' do
          get '/new/?' do
            erb :"/admin/groups/new", :layout => :"/layout/admin"
          end
          post '/create/?' do
            @group = current_user.groups.new(params[:group])
            if @group.save
              flash[:notice] = "你的小组 #{@group.name} 建立成功"
              redirect "/admin/group/#{@group.slug}"
            else
              flash[:errors] = @group.errors.messages
              redirect back
            end
          end
        end
        app.namespace '/admin/group/:slug/?' do
          before do
            unless params[:slug] =~ /new|create/
              @group = Group.find_by_slug!(params[:slug])
            end
          end
          put '/update/?' do
            if @group.update_attributes(params[:group])
              flash[:notice] = "#{@group.name} 更新成功"
              redirect back
            else
              flash[:errors] = @group.errors.messages
              redirect back
            end
          end
          delete '/delete/?' do
            @group_name = @group.name
            @group.destroy
            flash[:notice] = "小组 #{@group_name} 已删除"
            redirect '/admin/groups'
          end
          get '/?' do
            erb :"/admin/groups/show", :layout => :"/layout/admin"
          end
          get '/edit/?' do
            erb :"/admin/groups/edit", :layout => :"/layout/admin"
          end
        end
        app.get '/group/new/?' do
          erb :'/groups/new'
        end
      end
    end
  end
  register Coollala::GroupsController
end
# encoding: utf-8
module Sinatra
  module Coollala
    module GroupsController
      def self.registered(app)
        app.before '/groups/:slug/?' do
          unless params[:slug].scan(/new|create/).any?
            @group = Group.find_by_slug!(params[:slug])
          end
        end
        app.get '/group/:slug/?' do
          @group = Group.find_by_slug!(params[:slug])
          @topics = @group.topics.recent
          @title = @group.name
          erb :'/groups/index', :layout => :"/layout/layout"
        end
        app.post '/join/group/:slug/?' do
          group = Group.find_by_slug!(params[:slug])
          user = current_user
          members = Member.new(:user => user, :group => group)
          if members.save
            flash[:notice] = "加入小组成功"
            back
          else
            flash[:errors] = ["加入小组失败"]
            back
          end
        end
        app.delete '/quit/group/:slug/?' do
          group = Group.find_by_slug!(params[:slug])
          user = current_user
          quit_group = Member.where(:group_id => group.id, :user_id => user.id).first
          quit_group.destroy
          back
        end
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
            @group = Group.new(params[:group])
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
        app.get '/groups/new/?' do
          redirect '/sign_in' unless sign_in?
          @title = "创建小组"
          erb :'/groups/new', :layout => :'/layout/layout'
        end
        app.post '/groups/create/?' do
          @group = Group.new(params[:group])
          @group.user_id = current_user.id
          if @group.save
            Member.create(:group => @group, :user => current_user)
            flash[:notice] = "你的小组 #{@group.name} 建立成功"
            redirect "/group/#{@group.slug}"
          else
            flash[:errors] = @group.errors.messages
            redirect back
          end
        end
      end
    end
  end
  register Coollala::GroupsController
end
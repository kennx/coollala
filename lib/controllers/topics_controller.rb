# encoding: utf-8
module Sinatra
  module Coollala
    module TopicsController
      def self.registered(app)
        app.get '/' do
          @topics = Topic.explore
          @title = "浏览话题"
          erb :'/topics/index', :layout => :"/layout/layout"
        end
        app.get '/group/topic/:id/?' do
          @topic = Topic.find(params[:id])
          @title = @topic.title
          erb :'/topics/show', :layout => :"/layout/layout"
        end
        app.get '/group/:slug/new_topic/?' do
          redirect '/sign_in' unless sign_in?
          @group = Group.find_by_slug!(params[:slug])
          @title = "111在 #{@group.name} 创建话题"
          erb :'/topics/new', :layout => :"/layout/layout"
        end
        app.get '/group/topic/:id/edit/?' do
          @topic = Topic.find(params[:id])
          erb :'/topics/edit', :layout => :'/layout/layout'
        end
        app.put '/group/topic/:id/update/?' do
          @topic = Topic.find(params[:id])
          if @topic.update_attributes(params[:topic])
            flash[:notice] = "更新主题成功"
            redirect "/group/topic/#{@topic.id}"
          else
            flash[:errors] = @topic.errors.messages
            redirect "/group/topic/#{@topic.id}/edit"
          end
        end
        app.post '/group/:slug/create_topic/?' do
          @group = Group.find_by_slug!(params[:slug])
          @topic = @group.topics.new(params[:topic])
          @topic.user_id = current_user.id
          if @topic.save
            flash[:notice] = "话题创建成功"
            redirect "/group/#{@group.slug}"
          else
            flash[:errors] = @topic.errors.message
            redirect back
          end
        end
        app.namespace '/admin/?' do
          get '/topics/?' do
            @topics = Topic.all
            erb :'/admin/topics/index', :layout => :"/layout/admin"
          end
        end
        app.namespace '/admin/topic/?' do
          get '/new/?' do
            @title = '发表话题'
            erb :"/admin/topics/new", :layout => :"/layout/admin"
          end
          post '/create/?' do
            @topic = Topic.new(params[:topic])
            if @topic.save
              flash[:notice] = "发布话题成功"
              redirect "/admin/topic/#{@topic.id}"
            else
              flash[:errors] = @topic.errors.messages
              redirect back
            end
          end
        end
        app.namespace '/admin/topic/:id/?' do
          before do
            unless params[:id] =~ /new|create/
              @topic = Topic.find(params[:id])
            end
          end
          put '/update/?' do
            if @topic.update_attributes(params[:topic])
              flash[:notice] = "话题更新成功"
              redirect back
            else
              flash[:errors] = @topic.errors.messages
              redirect back
            end
          end
          delete '/delete/?' do
            @topic_title = @topic.title
            @topic.destroy
            flash[:notice] = "#{@topic_title} 已删除"
            redirect '/admin/topics'
          end
          get '/?' do
            erb :"/admin/topics/show", :layout => :"/layout/admin"
          end
          get '/edit/?' do
            erb :"/admin/topics/edit", :layout => :"/layout/admin"
          end
        end
      end
    end
  end
  register Coollala::TopicsController
end
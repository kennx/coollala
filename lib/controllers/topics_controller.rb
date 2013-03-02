# encoding: utf-8
module Sinatra
  module Coollala
    module TopicsController
      def self.registered(app)
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
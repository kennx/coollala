# encoding: utf-8
module Sinatra
  module Coollala
    module RepliesController
      def self.registered(app)
        app.post '/topic/:id/reply/create/?' do
          @topic = Topic.find(params[:id])
          @reply = @topic.replies.new(params[:reply])
          @reply.user_id = current_user.id
          if @reply.save
            flash[:notice] = "回复话题成功"
            redirect back
          else
            flash[:errors] = @reply.errors.messages
            redirect back
          end
        end
        app.delete '/reply/:id/destroy/?' do
          @reply = current_user.replies.find(params[:id])
          @reply.destroy
          back
        end
      end
    end
  end
  register Coollala::RepliesController
end

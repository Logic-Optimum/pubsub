module Pub
  module Sub
    class MessagesController < ApplicationController
      include Authenticate
      protect_from_forgery with: :null_session

      def create
        @topic = Topic.find params[:topic_id]
        Messages::Create.new.(topic: @topic, content: params[:message][:payload].as_json, client: @client)
      end
    end
  end
end

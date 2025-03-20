module Pub
	module Sub
		class MessagesController < ApplicationController
			include Authenticate

			def create
				@topic = Topic.find params[:topic_id]
				Messages::Create.new.(topic: @topic, content: JSON.parse(message_params[:payload]), client: @client)
			end

		private

			def message_params
				params.require(:message).permit(:payload)
			end
		end
	end
end

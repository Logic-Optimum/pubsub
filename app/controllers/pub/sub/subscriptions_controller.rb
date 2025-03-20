module Pub
	module Sub
		class SubscriptionsController < ApplicationController
			include Authenticate

			def create
				@topic = Topic.find params[:topic_id]
				@client.subscriptions.create callback_url: subscription_params[:callback_url], topic: @topic
			end

			def destroy
				@subscription = Subscription.find params[:id]

				unless @subscription.client == @client
					render status: :unauthorized, json: { error: "Unauthorized" } 
					return false
				end

				@subscription.destroy
			end

		private

			def subscription_params
				params.require(:subscription).permit(:callback_url, :id)
			end
		end
	end
end

module Pub
	module Sub
		class SubscriptionsController < ApplicationController
		  before_action :authenticate

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

			def authenticate
	      authenticate_or_request_with_http_token do |token, options|
	        @key = Key.find_by key: token

					unless @key.present?
		        render status: :unauthorized, json: { error: "Unauthorized" } 
		        return false
		      end

	        @client = @key.client
	      end
			end
		end
	end
end

module Pub
	module Sub
		module Authenticate
			extend ActiveSupport::Concern

			included do
			  before_action :authenticate

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

			class_methods do
			end
		end
	end
end
module Pub
  module Sub
    module Messages
      class Create
        attr_reader :message, :deliveries

        def call(topic:, content:, client:)
          create_message(topic: topic, content: content, client: client)
          create_deliveries(message: message)
          launch_delivery_processor_jobs(deliveries: deliveries)
        end

      private
        def launch_delivery_processor_jobs(deliveries:)
          deliveries.each do |delivery|
            DeliverJob.perform_later(delivery)
          end
        end

        def create_message(topic:, content:, client:)
          @message = client.messages.create topic: topic, content: content
        end

        def create_deliveries(message:)
          @deliveries = message.topic.subscriptions.map do |subscription|
            destination_client = subscription.client
            Delivery.create callback_url: subscription.callback_url, client: destination_client, message: @message
          end
        end
      end
    end
  end
end

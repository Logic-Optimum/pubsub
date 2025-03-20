module Pub
  module Sub
    class MessagesControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @routes = Engine.routes
        @topic = Topic.create name: "Test", description: "Test"
        @client = Client.create name: "Test Client", description: "Test Description"
        @another_client = Client.create name: "Test Client 2", description: "Test Description 2"
        @key = Key.create key: 'TheKey', client: @client
        @subscription = Subscription.create topic: @topic, client: @client, callback_url: callback_url
        @another_subscription = Subscription.create topic: @topic, client: @another_client, callback_url: callback_url
      end

      def test_create_success
        delivery_count = Delivery.count
        message_count = Message.count
        post topic_messages_path(@topic), params: valid_params, headers: header
        assert_response :success
        assert Delivery.count == delivery_count + Subscription.count
        assert Message.count == message_count + 1

        Delivery.all.each do |delivery|
          assert delivery.callback_url == callback_url
          assert delivery.message == Message.last
          assert delivery.client.present?
          assert delivery.success.nil?
        end
      end

      def test_create_failure_non_existing_topic
        post topic_messages_path(-1), params: valid_params, headers: header
        assert_response :missing
        assert Message.count == 0
      end

      def test_create_failure_unauthenticated_invalid_bearer
        post topic_messages_path(@topic), params: valid_params, headers: invalid_header
        assert_response 401
        assert Message.count == 0
      end

      def test_create_failure_unauthenticated_missing_header
        post topic_messages_path(@topic), params: valid_params
        assert_response 401
        assert Message.count == 0
      end

    private

      def callback_url
        'http://localhost:3000'
      end

      def payload
        { test: 'Test' }
      end

      def valid_params
        { message: { payload: payload.to_json } }
      end

      def header
        { Authorization: "Bearer #{@key.key}" }
      end

      def invalid_header
        { Authorization: "Bearer #{-1}" }
      end
    end
  end
end

module Pub
  module Sub
    class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @routes = Engine.routes
        @topic = Topic.create name: "Test", description: "Test"
      end

      def test_create_success
        subscription_count = Subscription.count
        post topic_subscriptions_path(@topic), params: valid_params, headers: header
        assert_response :success
        assert Subscription.count == subscription_count + 1
        assert Subscription.last.callback_url == callback_url
        assert Subscription.last.client == client
      end

      def test_create_failure_non_existing_topic
        post topic_subscriptions_path(-1), params: valid_params, headers: header
        assert_response :missing
        assert Subscription.count == 0
      end

      def test_create_failure_unauthenticated_invalid_bearer
        post topic_subscriptions_path(@topic), params: valid_params, headers: invalid_header
        assert_response 401
        assert Subscription.count == 0
      end

      def test_create_failure_unauthenticated_missing_header
        post topic_subscriptions_path(@topic), params: valid_params
        assert_response 401
        assert Subscription.count == 0
      end

      def test_destroy_success
        subscription = Subscription.create topic: @topic, client: client, callback_url: callback_url
        subscription_count = Subscription.count
        delete subscription_path(subscription), params: valid_params, headers: header
        assert_response :success
        assert Subscription.count == subscription_count - 1
      end

      def test_destroy_failure_somebody_elses_subscription
        another_client = Client.create name: "Another Test Client", description: "Test Description"
        another_subscription = Subscription.create topic: @topic, client: another_client, callback_url: callback_url
        subscription_count = Subscription.count

        delete subscription_path(another_subscription), params: valid_params, headers: header
        assert Subscription.count == subscription_count
        assert_response 401
      end

      def test_destroy_failure_unauthenticated_invalid_bearer
        subscription = Subscription.create topic: @topic, client: client, callback_url: callback_url
        subscription_count = Subscription.count
        delete subscription_path(subscription), params: valid_params, headers: invalid_header
        assert_response 401
        assert Subscription.count == subscription_count
      end

      def test_destroy_failure_unauthenticated_missing_header
        subscription = Subscription.create topic: @topic, client: client, callback_url: callback_url
        subscription_count = Subscription.count
        delete subscription_path(subscription), params: valid_params
        assert_response 401
        assert Subscription.count == subscription_count
      end

      def callback_url
        'http://localhost/callback_url'
      end

      def valid_params
        { subscription: { callback_url: callback_url } }
      end

      def key
        @key ||= Key.create key: 'TheKey', client: client
      end

      def client
        @client ||= Client.create name: "Test Client", description: "Test Description"
      end

    private
      def header
        { Authorization: "Bearer #{key.key}" }
      end

      def invalid_header
        { Authorization: "Bearer #{-1}" }
      end
    end
  end
end

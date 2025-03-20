require "test_helper"

module Pub::Sub
  class DeliverJobTest < ActiveJob::TestCase
      # - For every subscription belonging to the topic the message belongs to initiates a delivery as a background job:
      #    - by default "success: nil"
      #    - Every nil or false is TRYed to call back
      #    - if the callback succeedes set to TRUE
      #    - if the HTTP callback fails set to false, then reschedule another delivery 5 minutes after the failure.
      #    - Optionally after the Nth try notify someone!!! (mail)

      setup do
        @topic = Topic.create name: "Test", description: "Test"
        @client = Client.create name: "Test Client", description: "Test Description"
        @key = Key.create key: "TheKey", client: @client
        @subscription = Subscription.create topic: @topic, client: @client, callback_url: callback_url
        @message = Message.create topic: @topic, creator: @client, content: "content"
        @delivery = Delivery.create client: @client, callback_url: callback_url, message: @message
      end


    test "success" do
      delivery_counts = Delivery.count
      job = DeliverJob.new
      def job.callback_the_receiving_endpoint(delivery)
      end
      job.perform(@delivery)
      assert Delivery.count == delivery_counts
      assert @delivery.success == true
    end

    test "failure the url does not respond with 201" do
      delivery_counts = Delivery.count
      job = DeliverJob.new
      def job.callback_the_receiving_endpoint(delivery)
        raise DeliverJob::InvalidCallback
      end
      job.perform(@delivery)
      assert Delivery.count == delivery_counts + 1
      assert @delivery.success == false
      assert Delivery.last.success == nil
      assert Delivery.last.client == @delivery.client
      assert Delivery.last.message == @delivery.message
      assert Delivery.last.callback_url == @delivery.callback_url
    end

  private

    def callback_url
      "http://localhost"
    end
  end
end

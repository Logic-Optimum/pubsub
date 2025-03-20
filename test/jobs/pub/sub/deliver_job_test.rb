require "test_helper"

module Pub::Sub
  class DeliverJobTest < ActiveJob::TestCase
    # - For every subscription belonging to the topic the message belongs to initiates a delivery as a background job:
    #    - by default "success: nil"
    #    - Every nil or false is TRYed to call back
    #    - if the callback succeedes set to TRUE
    #    - if the HTTP callback fails set to false, then reschedule another delivery 5 minutes after the failure.
    #    - Optionally after the Nth try notify someone!!! (mail)

      # setup do
      #   @topic = Topic.create name: "Test", description: "Test"
      #   @client = Client.create name: "Test Client", description: "Test Description"
      #   @another_client = Client.create name: "Test Client 2", description: "Test Description 2"
      #   @key = Key.create key: 'TheKey', client: @client
      #   @subscription = Subscription.create topic: @topic, client: @client, callback_url: callback_url
      #   @another_subscription = Subscription.create topic: @topic, client: @another_client, callback_url: callback_url
      # end


    test "success" do
      # DeliverJob.new.perform(delivery)
      assert true
    end

    test "failure the url does not respond with 201" do
      # DeliverJob.new.perform(delivery)

      assert true
    end
  end
end

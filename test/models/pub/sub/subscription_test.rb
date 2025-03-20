require "test_helper"

module Pub::Sub
  class SubscriptionTest < ActiveSupport::TestCase
    context "validations" do
      should validate_presence_of(:callback_url)
    end

    context "assotiations" do
      should belong_to(:topic)
      should belong_to(:client)
    end

    test "fields" do
      subject = Subscription.new

      assert subject.respond_to? :callback_url
    end
  end
end

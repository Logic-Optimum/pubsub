require "test_helper"

module Pub::Sub
  class DeliveryTest < ActiveSupport::TestCase
    context "assotiations" do
      should belong_to(:client)
      should belong_to(:message)
    end
  end
end

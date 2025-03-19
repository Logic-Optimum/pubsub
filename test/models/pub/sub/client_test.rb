require "test_helper"

module Pub::Sub
  class ClientTest < ActiveSupport::TestCase
    context "assotiations" do
      should have_many(:keys)
      should have_many(:subscriptions)
      # should have_many(:deliveries)
    end

    test 'fields' do
      client = Client.new

      assert client.respond_to? :name
      assert client.respond_to? :description
    end
  end
end

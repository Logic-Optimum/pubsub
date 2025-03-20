require "test_helper"

module Pub::Sub
  class ClientTest < ActiveSupport::TestCase
    context "assotiations" do
      should have_many(:keys)
      should have_many(:subscriptions)
      should have_many(:deliveries)
      should have_many(:messages)
    end

    context "validations" do
      should validate_presence_of(:name)
      should validate_presence_of(:description)
    end

    test 'fields' do
      client = Client.new

      assert client.respond_to? :name
      assert client.respond_to? :description
    end
  end
end

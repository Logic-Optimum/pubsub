require "test_helper"

module Pub::Sub
  class TopicTest < ActiveSupport::TestCase
    context "assotiations" do
      should have_many(:messages)
      should have_many(:subscriptions)
    end

    context "validations" do
      should validate_presence_of(:name)
      should validate_presence_of(:description)
    end

    test 'The Client Fields' do
      client = Topic.new

      assert client.respond_to? :name
      assert client.respond_to? :description
    end
  end
end

require "test_helper"

module Pub::Sub
  class MessageTest < ActiveSupport::TestCase
    context "validations" do
      should validate_presence_of(:content)
    end

    context "assotiations" do
      should belong_to(:topic)
      should belong_to(:creator)
      should have_many(:deliveries)
    end

    test "fields" do
      subject = Message.new

      assert subject.respond_to? :content
    end
  end
end

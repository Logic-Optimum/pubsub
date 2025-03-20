require "test_helper"

module Pub::Sub
  class KeyTest < ActiveSupport::TestCase
    context "assotiations" do
      should belong_to(:client)
    end

    context "validations" do
      should validate_presence_of(:key)
    end

    test 'fields' do
      subject = Key.new

      assert subject.respond_to? :key
    end
  end
end

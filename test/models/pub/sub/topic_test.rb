require "test_helper"

module Pub::Sub
  class TopicTest < ActiveSupport::TestCase
    test 'The Client Fields' do
      client = Topic.new

      assert client.respond_to? :name
      assert client.respond_to? :description
    end
  end
end

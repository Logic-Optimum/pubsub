require "test_helper"

module Pub::Sub
  class KeyTest < ActiveSupport::TestCase
    context "assotiations" do
      should belong_to(:client)
    end
  end
end

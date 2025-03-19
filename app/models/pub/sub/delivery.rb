module Pub::Sub
  class Delivery < ApplicationRecord
    belongs_to :message, foreign_key: :pub_sub_message_id
    belongs_to :client, foreign_key: :pub_sub_client_id
  end
end

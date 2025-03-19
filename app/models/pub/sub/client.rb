module Pub::Sub
  class Client < ApplicationRecord
    has_many :keys, foreign_key: :pub_sub_client_id
    has_many :subscriptions, foreign_key: :pub_sub_client_id
    has_many :deliveries, foreign_key: :pub_sub_client_id
    has_many :messages, foreign_key: :pub_sub_client_id
  end
end

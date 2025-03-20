module Pub::Sub
  class Subscription < ApplicationRecord
    belongs_to :client, foreign_key: :pub_sub_client_id
    belongs_to :topic, foreign_key: :pub_sub_topic_id

    validates :callback_url,
              presence: true
  end
end

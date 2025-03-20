module Pub::Sub
  class Message < ApplicationRecord
    belongs_to :topic, foreign_key: :pub_sub_topic_id
    belongs_to :creator, class_name: "Client", foreign_key: :pub_sub_client_id
    has_many :deliveries, foreign_key: :pub_sub_message_id

    validates :content,
              presence: true
  end
end

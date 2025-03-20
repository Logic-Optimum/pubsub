module Pub::Sub
  class Topic < ApplicationRecord
    has_many :messages, foreign_key: :pub_sub_topic_id
    has_many :subscriptions, foreign_key: :pub_sub_topic_id

    validates :name,
              presence: true

    validates :description,
              presence: true

  end
end

module Pub::Sub
  class Key < ApplicationRecord
    belongs_to :client, foreign_key: :pub_sub_client_id, inverse_of: :keys
  end
end

module Pub
  module Sub
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end

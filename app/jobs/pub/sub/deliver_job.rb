module Pub::Sub
  class DeliverJob < ApplicationJob
    queue_as :default

    def perform(delivery)
      # - For every subscription belonging to the topic the message belongs to initiates a delivery as a background job:
      #    - by default "success: nil"
      #    - Every nil or false is TRYed to call back
      #    - if the callback succeedes set to TRUE
      #    - if the HTTP callback fails set to false, then reschedule another delivery 5 minutes after the failure.
      #    - Optionally after the Nth try notify someone!!! (mail)

      # MyJob.set(priority: 50).perform_later(record)
      # Do something later
    end
  end
end

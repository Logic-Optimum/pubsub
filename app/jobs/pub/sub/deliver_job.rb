module Pub::Sub
  class DeliverJob < ApplicationJob
    InvalidCallback = Class.new(StandardError)

    RETRY_WAIT_TIME = 5.minutes

    queue_as :default

    attr_reader :new_delivery

    def perform(delivery)
      return if delivery.success

      callback_the_receiving_endpoint(delivery)
      set_success(delivery)
    rescue InvalidCallback
      set_failure(delivery)
      create_new_delivery(delivery)
      DeliverJob.set(wait: RETRY_WAIT_TIME).perform_later(new_delivery)
    end

private

    def callback_the_receiving_endpoint(delivery)
      response = RestClient.post(delivery.callback_url, delivery.message.content, headers={})
      raise InvalidCallback unless response.code == 201
    end

    def create_new_delivery(delivery)
      @new_delivery = Delivery.create client: delivery.client, message: delivery.message, callback_url: delivery.callback_url
    end

    def set_failure(delivery)
      delivery.update success: false
    end

    def set_success(delivery)
      delivery.update success: true
    end
  end
end

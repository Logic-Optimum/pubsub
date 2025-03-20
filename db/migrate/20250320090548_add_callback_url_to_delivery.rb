class AddCallbackUrlToDelivery < ActiveRecord::Migration[8.0]
  def change
    add_column :pub_sub_deliveries, :callback_url, :string
  end
end

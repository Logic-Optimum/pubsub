class CreatePubSubClients < ActiveRecord::Migration[8.0]
  def change
    create_table :pub_sub_clients do |t|
      t.string :name
      t.text   :description

      t.timestamps
    end
  end
end

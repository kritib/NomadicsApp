class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.integer :travel_id
      t.integer :request_id

      t.timestamps
    end
  end
end

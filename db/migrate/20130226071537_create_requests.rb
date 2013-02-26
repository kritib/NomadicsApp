class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.string :from
      t.string :to
      t.date :date
      t.string :item_size
      t.integer :item_weight
      t.integer :item_legality
      t.string :item_description
      t.integer :requester_id

      t.timestamps


      t.timestamps
    end
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :travel_id
      t.integer :commenter_id
      t.integer :request_id
      t.text :body

      t.timestamps
    end
  end
end

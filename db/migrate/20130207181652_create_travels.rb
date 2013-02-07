class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :from
      t.string :to
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end

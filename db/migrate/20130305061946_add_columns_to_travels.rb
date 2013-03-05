class AddColumnsToTravels < ActiveRecord::Migration
  def change
    add_column :travels, :from, :integer
    add_column :travels, :to, :integer
    add_column :requests, :from, :integer
    add_column :requests, :to, :integer
  end
end

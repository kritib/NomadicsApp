class RemoveColumnsFromTravels < ActiveRecord::Migration
  def up
    remove_column :travels, :from
    remove_column :travels, :to
    remove_column :requests, :from
    remove_column :requests, :to
  end

  def down
    add_column :travels, :from, :string
    add_column :travels, :to, :string
    add_column :requests, :from, :string
    add_column :requests, :to, :string
  end
end

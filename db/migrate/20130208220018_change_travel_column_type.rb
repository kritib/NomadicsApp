class ChangeTravelColumnType < ActiveRecord::Migration
  def up
  	change_column :travels, :from, :integer
  	change_column :travels, :to, :integer
  end

  def down
  	change_column :travels, :from, :string
  	change_column :travels, :to, :string
  end
end

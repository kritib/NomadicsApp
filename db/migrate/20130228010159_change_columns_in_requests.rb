class ChangeColumnsInRequests < ActiveRecord::Migration
  def up
    change_column :requests, :from, :integer
    change_column :requests, :to, :integer
  end

  def down
    change_column :requests, :from, :string
    change_column :requests, :to, :string
  end
end

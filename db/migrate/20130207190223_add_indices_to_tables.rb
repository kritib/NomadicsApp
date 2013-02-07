class AddIndicesToTables < ActiveRecord::Migration
  def change
  	add_index :relationships, :user_id
  	add_index :relationships, :friend_id
  	add_index :users, :email, :unique => true
  	add_index :travels, :user_id
  end
end

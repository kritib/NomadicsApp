class AddColumnMuleIdToRequests < ActiveRecord::Migration
  def change

    add_column :requests, :mule_id, :integer
  end
end

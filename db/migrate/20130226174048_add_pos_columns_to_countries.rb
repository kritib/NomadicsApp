class AddPosColumnsToCountries < ActiveRecord::Migration
  def change
  	add_column :countries, :x, :integer
  	add_column :countries, :y, :integer

  end
end

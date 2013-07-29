class AddSchoolMottoTypeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :school, :string
  	add_column :users, :motto, :string
  	add_column :users, :role, :string, :limit => 10 
  end
end

class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :fb_id , :limit => "50"
      t.string :name
    end
  end
end

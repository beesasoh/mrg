class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name , :limit => 100
      t.string :email , :limit => 100
      t.text :bio

      t.timestamps
    end
  end
end

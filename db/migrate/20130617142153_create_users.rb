class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider , :limit => 100
      t.string :uid , :limit => 100 , :null => false
      t.string :name , :limit => 100 , :null => false
      t.string :email, :limit => 100, :null => false
      t.string :image
      t.integer :coins
      t.integer :level
      t.string :oauth_token , :null => false
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end

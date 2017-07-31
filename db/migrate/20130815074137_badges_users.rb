class BadgesUsers < ActiveRecord::Migration
  def up
  	create_table :badges_users do |t|
  		t.integer "user_id"
  		t.integer "badge_id"
  	end
  	add_index :badges_users , ["user_id","badge_id"]
  end

  def down
  	drop_table :badges_users
  end
end

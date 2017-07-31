class CreateUserCoursesTable < ActiveRecord::Migration
  def up
  	create_table :courses_users do |t|
  		t.integer "user_id"
  		t.integer "course_id"
  	end
  	add_index :courses_users , ["user_id","course_id"]
  end

  def down
  	drop_table :courses_users
  end
end

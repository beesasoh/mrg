class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.references :course
    	t.references :subject
    	t.references :user
      	t.integer :score

      t.timestamps
    end
    add_index :games , :course_id
    add_index :games , :subject_id
    add_index :games , :user_id
  end
end

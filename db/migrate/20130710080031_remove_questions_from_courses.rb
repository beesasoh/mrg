class RemoveQuestionsFromCourses < ActiveRecord::Migration
  def up
  	remove_column :courses , :num_questions
  	remove_column :courses , :questions
  end

  def down
  	add_column :courses, :questions, :text
  	add_column :courses, :num_questions, :integer
  end
end

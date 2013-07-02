class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :author
      t.references :subject
      t.string :title ,:limit => 100
      t.integer :num_questions
      t.integer :level
      t.integer :cost
      t.text :questions #stores a json object of all questions

      t.timestamps
    end
    add_index("courses","author_id")
    add_index("courses","subject_id")
  end
end

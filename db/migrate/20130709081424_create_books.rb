class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.references :author
      t.references :subject
      t.text :description
      t.text :content

      t.timestamps
    end
    add_index("books","author_id")
    add_index("books","subject_id")
  end
end

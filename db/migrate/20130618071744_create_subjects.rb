class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name , :limit => 100

      t.timestamps
    end
  end
end

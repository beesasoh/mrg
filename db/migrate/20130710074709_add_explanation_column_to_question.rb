class AddExplanationColumnToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :explanation, :text, :null => true, :after => :question
  end
end

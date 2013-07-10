class AddPublishStatusToBook < ActiveRecord::Migration
  def change
  	add_column :books, :published, :boolean, :default => true, :after => :subject_id
  end
end

class AddPublishStatusToCourse < ActiveRecord::Migration
  def change
  	add_column :courses , :published , :boolean , :default => false , :after => :title
  end
end

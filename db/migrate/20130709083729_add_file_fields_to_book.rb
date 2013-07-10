class AddFileFieldsToBook < ActiveRecord::Migration
  def change
  	add_attachment :books , :book_file
  end
end

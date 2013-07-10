class AddImageToQuestion < ActiveRecord::Migration
  def change
  	add_attachment :questions , :image
  end
end

class AddImageToBadge < ActiveRecord::Migration
  def change
  	add_attachment :badges , :image
  end
end

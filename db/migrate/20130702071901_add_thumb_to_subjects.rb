class AddThumbToSubjects < ActiveRecord::Migration
  def change
  	add_attachment :subjects , :image_thumb
  end
end

class Badge < ActiveRecord::Base
  attr_accessible :description, :name ,:image

  has_attached_file :image #, :styles => {:thumb => "220x140"} , :default_url => "images/missing_sub.jpg"

  validates_presence_of :name , :description
end

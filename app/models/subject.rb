class Subject < ActiveRecord::Base
  attr_accessible :name , :image_thumb

  has_many :courses
  has_many :games_played , :class_name => :game
  has_attached_file :image_thumb , :styles => {:thumb => "220x140"} , :default_url => "images/missing_sub.jpg"

  validates :name, :presence => true
  validates_attachment :image_thumb, :presence => true,
  										:size => { :in => 1..20.kilobytes }
end

class Course < ActiveRecord::Base
  attr_accessible :cost, :level, :title , :author_id , :subject_id , :published

  belongs_to :author
  belongs_to :subject
  has_many :questions
  has_many :games_played , :class_name => :game
  has_and_belongs_to_many :users

  validates :title, :presence => true
  validates :level, :presence => true
  validates :cost, :presence => true, :numericality => {:only_integer => true}
end

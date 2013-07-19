class Course < ActiveRecord::Base
  attr_accessible :cost, :level, :title , :author_id , :subject_id , :published

  belongs_to :author
  belongs_to :subject
  has_many :questions , :dependent => :destroy
  has_many :games_played , :class_name => :game
  has_and_belongs_to_many :users

  validates_presence_of :title, :level, :cost
  validates :cost, :numericality => {:only_integer => true}
  validates :published, inclusion: [true,false]
end






























class Question < ActiveRecord::Base
  attr_accessible :question, :course_id , :image

  belongs_to :course
  has_many :choices
  has_attached_file :image

  validates :question, :presence => true
  validates :course_id, :presence => true
end

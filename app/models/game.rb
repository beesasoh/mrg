class Game < ActiveRecord::Base
  attr_accessible :score , :subject_id , :user_id , :course_id

  belongs_to :user
  belongs_to :course
  belongs_to :subject

  validates :subject_id, :presence => true
  validates :user_id, :presence => true
  validates :course_id, :presence => true
end

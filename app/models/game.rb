class Game < ActiveRecord::Base
  attr_accessible :score , :subject_id , :user_id , :course_id

  belongs_to :user
  belongs_to :course
  belongs_to :subject

  validates_presence_of :subject_id, :user_id , :course_id , :score
end

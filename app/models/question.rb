class Question < ActiveRecord::Base
  attr_accessible :question, :course_id , :image , :explanation

  belongs_to :course
  has_many :choices , :dependent => :destroy
  has_attached_file :image

  validates_presence_of :question, :course_id

end

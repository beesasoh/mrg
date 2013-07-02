class Course < ActiveRecord::Base
  attr_accessible :cost, :level, :title ,:num_questions, :questions

  belongs_to :author
  belongs_to :subject
  has_and_belongs_to_many :users

  validates :title, :presence => true
  validates :level, :presence => true
  validates :num_questions, :presence => true
  validates :cost, :presence => true, :numericality => {:only_integer => true}
end

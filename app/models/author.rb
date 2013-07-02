class Author < ActiveRecord::Base
  attr_accessible :bio, :email, :name

  has_many :courses

  validates :name , :presence => true
  validates :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end

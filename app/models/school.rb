class School < ActiveRecord::Base
  attr_accessible :fb_id, :name

  has_many :users
end

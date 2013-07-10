class Choice < ActiveRecord::Base
 	attr_accessible :choice, :correct, :question_id

 	belongs_to :question

 	validates :choice, :presence => true
 	validates :question_id, :presence => true
end

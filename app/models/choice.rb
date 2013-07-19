class Choice < ActiveRecord::Base
 	attr_accessible :choice, :correct, :question_id

 	belongs_to :question

 	validates_presence_of :choice, :question_id
end

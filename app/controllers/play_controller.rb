class PlayController < ApplicationController

	before_filter :confirm_logged_in  
  def index
  	require 'json'
  	@course = Course.find_by_id(params[:id])
  end

  def create 
  		results_hash = Hash.new
  		if request.get?
  			results_hash["message"] = "dont be a hero"
			render json: results_hash
		else
			score = params[:score]
		  	course_id = params[:course]
		  	course = Course.find(course_id)

		  	game = Game.new
		  	game.user = User.find(2)
		  	game.course = course
		  	game.subject = course.subject
		  	game.score = score
		  	game.created_at = Date.today

		  	if game.save
		  		#todo
		  		#display results of play
		  		results_hash["message"] = "Weldone"
		  		render json: results_hash
		  	else
		  		results_hash["message"] = "failed due to error"
		  		render json: results_hash
		  	end
		end
  end

end

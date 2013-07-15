class PlayController < ApplicationController
  
  def index
  	require 'json'
  	@course = Course.find_by_id(params[:id])
  end

  def game  	
  	custom = Hash.new

  	if request.post?
	  	score = params[:score]
	  	course_id = params[:course]
	  	course = Course.find(course_id)

	  	game = Game.new
	  	game.user = User.find(2)
	  	game.course = course
	  	game.subject = course.subject
	  	game.score = score

	  	if game.save
	  		custom["message"] = "Weldone"
	  		render json: custom
	  	else
	  		custom["message"] = "failed due to error"
	  		render json: custom
	  	end
	else
		custom["message"] = "Dont be a hero"
		render json: custom
	end
  end

end

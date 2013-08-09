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
		  	game.user = current_user
		  	game.course = course
		  	game.subject = course.subject
		  	game.score = score
		  	game.created_at = Date.today

		  	if game.save
		  		@rankings = Game.rankings
		  		@rankings_today = Game.rankings_today
		  		@rankings_this_week = Game.rankings_this_week
		  		@rankings_friends = Game.friends_ranking current_user
		  		@performance = current_user.performance_in_course(course_id)
 		  		render :layout =>'game'
		  	else
		  		render :layout =>'game'
		  	end
		end
  end

  def fb_share
  	message = params[:message]
  	current_user.post_to_wall(message)
  	render :text => "posted"
  end

end

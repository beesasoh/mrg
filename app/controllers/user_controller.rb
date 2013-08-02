class UserController < ApplicationController
	layout "game"
	before_filter :confirm_logged_in

	def index
		if (@user = User.find_by_id(params[:id])).nil?
			not_found
		else
			@stats = @user.stats.to_a
			render :layout => "application.html.erb"
		end
	end

	def me
		@user = current_user
		@stats = @user.stats.to_a
		render :layout => "application.html.erb"
	end

	def school_info
		if current_user.school.nil?
			#render the form for school options
		else
			render :text => "ok"
		end
	end

	def school
		school_name = params["sch_name"]
		school_id = params["sch_id"]
		if (School.find_by_fb_id(school_id).nil?)
			sc = School.new
			sc.name = school_name
			sc.fb_id = school_id
			if sc.save
				current_user.update_attributes(:school_id => sc.id)
			end
		else
			sc = School.find_by_fb_id(school_id)
			current_user.update_attributes(:school_id => sc.id)
		end
		render :text => "ok"
	end

	def motto
		if current_user.motto.nil? || current_user.motto.strip.size == 0
			#form for entering motto
		else
			render :text => "ok"
		end
	end

	def add_motto
		motto = params["user_motto"]
		current_user.update_attributes(:motto => motto)
		render :text => "ok"
	end
end

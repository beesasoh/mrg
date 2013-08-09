class PerformanceController < ApplicationController

	def index
		@user = params[:id].nil? ? current_user : User.find_by_id(params[:id])
		@data = @user.performance
		@last_days = @user.performance_last_7_days
	end

end

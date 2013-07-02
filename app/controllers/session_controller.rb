class SessionController < ApplicationController
	def create
		user = User.create_user_from(env["omniauth.auth"])
		session[:user_id] = user.id
		redirect_to root_url
	end

	def destroy
		session["user_id"] = nil
		redirect_to root_url
	end

end

class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  protected
  
  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Please login"
  		redirect_to("/")
  		return false
  	else
  		return true
  	end
  end

end

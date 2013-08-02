class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_graph
    Koala::Facebook::API.new(current_user.oauth_token)
  end
  helper_method :user_graph

  protected 

  def not_found
    redirect_to :controller => 'home' , :action => 'index'
  end

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

  def confirm_admin
    user = User.find(session[:user_id])
    if user.role == "admin"
      return true
    else
      flash[:notice] = "Please login"
      redirect_to("/")
      return false
    end
  end

end

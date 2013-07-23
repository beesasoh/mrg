class HomeController < ApplicationController

	before_filter :confirm_logged_in
  def index
  	@subjects = Subject.all
  end

  def authorize
  end
end

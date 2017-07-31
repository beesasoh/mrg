class HomeController < ApplicationController

	before_filter :confirm_logged_in , :except => [:authorize]
  def index
  	@subjects = Subject.all
  end

  def authorize
  	render :layout => "game.html.erb"
  end
end

class HomeController < ApplicationController
  def index
  	@subjects = Subject.all
  end

  def authorize
  end
end

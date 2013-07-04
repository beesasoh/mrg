class HomeController < ApplicationController
  def index
  	@subjects = Subject.all
  end
end

class SubjectsController < ApplicationController
	layout 'ajax_page'
  def index
  	list
  	render 'list'
  end

  def list
  	@subjects = Subject.all;
  end
end

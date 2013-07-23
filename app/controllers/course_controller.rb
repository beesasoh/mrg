class CourseController < ApplicationController

	before_filter :confirm_logged_in
  def index
    list
    render 'list'
  end

  def list
    @courses = Course.all
  end

end

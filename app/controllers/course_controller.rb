class CourseController < ApplicationController
  def index
    list
    render 'list'
  end

  def list
    @courses = Course.all
  end

end

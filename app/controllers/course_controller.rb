class CourseController < ApplicationController
  def index
    list
    render 'list'
  end

  def list
    @courses = Course.all
  end

  def new
    @course = Course.new(:author_id => 3,
                          :cost => 0,
                          :level => 2)
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:notice] = "Test has been created"
      redirect_to(:action => 'list')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end
end

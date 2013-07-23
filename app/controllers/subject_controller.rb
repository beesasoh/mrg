class SubjectController < ApplicationController

  before_filter :confirm_logged_in
  def index
    list
    render 'list'
  end

  def list
    @subjects = Subject.all
  end

  def quizzes
    @subject = Subject.find(params[:id])
    render 'quiz'
  end

end

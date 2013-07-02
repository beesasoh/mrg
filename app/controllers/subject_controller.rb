class SubjectController < ApplicationController

  def index
    list
    render 'list'
  end

  def list
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      flash[:notice] = "New subject has been created"
      redirect_to(:action => 'list')
    else
      render 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
     @subject = Subject.find(params[:id])
     if @subject.update_attributes(params[:subject])
        flash[:notice] = "Subject updated"
        redirect_to(:action => 'list')
      else
        render 'edit'
      end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    #deleting a subject means to delete all courses under it.
    subject = Subject.find(params[:id])
    subject.destroy
    flash[:notice] = "Subject has been deleted"
    redirect_to(:action => 'list')
  end
end

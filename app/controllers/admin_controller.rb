class AdminController < ApplicationController
	layout "admin"
	def index
	end

	def list_subject
		@subjects = Subject.all
	end

	def new_subject
		@subject = Subject.new
	end

	def create_subject
	@subject = Subject.new(params[:subject])
	    if @subject.save
	      flash[:notice] = "New subject has been created"
	      redirect_to(:action => 'list_subject')
	    else
	      render 'new_subject'
	    end
	end

	def edit_subject
		 @subject = Subject.find_by_id(params[:id])
	end

	def update_subject
		@subject = Subject.find(params[:id])
	     if @subject.update_attributes(params[:subject])
	        flash[:notice] = "Subject updated"
	        redirect_to(:action => 'list_subject')
	      else
	        render 'edit_subject'
	      end
	end

	def delete_subject
		@subject = Subject.find(params[:id])
	end 

	def destroy_subject
		#deleting a subject means to delete all courses under it.
	    subject = Subject.find(params[:id])
	    subject.destroy
	    flash[:notice] = "Subject has been deleted"
	    redirect_to(:action => 'list_subject')
	end 

end

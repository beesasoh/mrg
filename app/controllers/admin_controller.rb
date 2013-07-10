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

	def list_course
		@courses = Course.all
	end

	def new_course
		 @course = Course.new(:author_id => 3 , :cost => 0 , :level => 2)
	end

	def create_course
		@course = Course.new(params[:course])
	    if @course.save
	      flash[:notice] = "Test has been created"
	      redirect_to(:action => 'list_course')
	    else
	      render 'new_course'
	    end
	end

	def edit_course
		 @course = Course.find_by_id(params[:id])
	end

	def update_course
		@course = Course.find(params[:id])
	     if @course.update_attributes(params[:course])
	        flash[:notice] = "Course updated"
	        redirect_to(:action => 'list_course')
	      else
	        render 'edit_course'
	      end
	end

	def delete_course
		@course = Course.find_by_id(params[:id])
	end

	def destroy_course
		#deleting a course/test means to delete all of its questions and choices
	    course = Course.find(params[:id])
	    course.destroy
	    flash[:notice] = "Course has been deleted"
	    redirect_to(:action => 'list_course')
	end

	def list_book
		@books = Book.all
	end

	def new_book
		 @book = Book.new(:author_id => 3)
	end

	def create_book
		 @book = Book.new(params[:book])
	    if @book.save
	      flash[:notice] = "New book has been created"
	      redirect_to(:action => 'list_book')
	    else
	      render 'new_book'
	    end
	end

	def edit_book
		@book = Book.find_by_id(params[:id])
	end

	def update_book
		@book = Book.find(params[:id])
	     if @book.update_attributes(params[:book])
	        flash[:notice] = "Book updated"
	        redirect_to(:action => 'list_book')
	      else
	        render 'edit_book'
	      end
	end

	def delete_book
		@book = Book.find_by_id(params[:id])
	end

	def destroy_book
		book = Book.find(params[:id])
	    book.destroy
	    flash[:notice] = "Book has been deleted"
	    redirect_to(:action => 'list_book')
	end

end

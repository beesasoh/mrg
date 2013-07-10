class BookController < ApplicationController
  def index
    list
    render 'list'
  end

  def list
    @books = Book.all
  end

  def new
    @book = Book.new(:author_id => 3)
  end

  def view
    @book = Book.find(params[:id]);
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = "New subject has been created"
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

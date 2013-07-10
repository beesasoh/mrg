class BookController < ApplicationController
  def index
    list
    render 'list'
  end

  def list
    @books = Book.all
  end


  def view
    @book = Book.find(params[:id]);
  end

end

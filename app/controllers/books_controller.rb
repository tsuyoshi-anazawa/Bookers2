class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]



  def index
  	@post_book = Book.new

  	@books = Book.all

  end

  def show
  	@post_book = Book.new

  	@book = Book.find(params[:id])
  end

  def create
    @post_book = Book.new
    @books = Book.all
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
    if
      @book.save
      flash[:notice] = "Book was successfully created"
  	  redirect_to book_path(@book.id)

    else
      render :index
    end
  end


  def edit
  	@book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if
     book.update(book_params)
     flash[:notice] = "Book was successfully edited"
     redirect_to book_path(book.id)
    end
  end

  def destroy
  	book = Book.find(params[:id])
    if
  	 book.destroy
     flash[:notice] = "Book was successfully deleted"
  	 redirect_to books_path
    end
  end


  private
  def book_params
  	params.require(:book).permit(:title,:opinion)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to root_path
    end
  end

end

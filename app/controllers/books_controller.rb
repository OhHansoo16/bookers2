class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end
  
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def index
    if params[:latest]
      @books = Book.latest
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.all
    end
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
    @book_new = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :category)
  end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end
end

class UsersController < ApplicationController
  
  def index
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to books_path
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to books_path
    end
  end
end

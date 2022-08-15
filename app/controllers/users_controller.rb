class UsersController < ApplicationController
  
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
    
  end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
    if current_user == @user
    else
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      @users = User.all
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  
end

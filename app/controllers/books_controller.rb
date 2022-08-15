class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "successfully"
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def show
   @books = Book.new
   @book = Book.find(params[:id])
   @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])  
    book.destroy
    redirect_to '/books'
    flash[:notice] = "successfully"
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)  
  end
  
  
end

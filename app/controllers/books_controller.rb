class BooksController < ApplicationController

  def show
  	@book = Book.find_by(id: params[:id])
    @user = current_user
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @user = current_user
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user = current_user
  	if @book.save #入力されたデータをdbに保存する。
      flash[:notice] = "successfully created book!"
  		redirect_to("/books")#保存された場合の移動先を指定。
  	else
  		@books = Book.all
      @user = current_user
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title,:body)
  end

end

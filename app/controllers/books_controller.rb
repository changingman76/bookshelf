class BooksController < ApplicationController
  def index
    redirect_to books_list_path
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Buch wurde erfolgreich erstellt.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'Buch wurde erfolgreich aktualisiert.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_list_path, notice: 'Buch wurde gelöscht.'
  end

  def list
    if params[:q].present?
      query = "%#{params[:q]}%"
      adapter = ActiveRecord::Base.connection.adapter_name.downcase
      if adapter.include?("sqlite")
        @books = Book.where(
          "COALESCE(title, '') LIKE ? OR COALESCE(author, '') LIKE ? OR COALESCE(description, '') LIKE ? OR COALESCE(location, '') LIKE ?",
          query, query, query, query
        )
      else
        @books = Book.where(
          "COALESCE(title, '') ILIKE ? OR COALESCE(author, '') ILIKE ? OR COALESCE(description, '') ILIKE ? OR COALESCE(location, '') ILIKE ?",
          query, query, query, query
        )
      end
    else
      @books = Book.all
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :published_on)
  end
end

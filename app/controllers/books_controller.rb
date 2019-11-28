# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = current_user.books.page params[:page]
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params.merge(user_id: current_user.id))

    if @book.save
      redirect_to @book, notice: t('errors.messages.Book_was_successfully_created.')
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('errors.messages.Book_was_successfully_updated.')
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: t('errors.messages.Book_was_successfully_destroyed.')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = current_user.books.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture, :user_id)
    end
end

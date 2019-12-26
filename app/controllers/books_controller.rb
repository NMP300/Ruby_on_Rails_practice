# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_created_book, only: [:edit, :update, :destroy]

  def index
    following_users = current_user.following
    @books = Book.where(user_id: following_users).or(Book.where(user_id: current_user)).order(created_at: :desc).page params[:page]
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by(id: params[:id])
    @comments = @book.comments
    @comment = Comment.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params.merge(user_id: current_user.id))

    if @book.save
      redirect_to @book, notice: t("successfully.Book_was_successfully_created.")
    else
      render :new, notice: t("errors.messages.Book_was_failuer_created.")
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("successfully.Book_was_successfully_updated.")
    else
      render :edit, notice: t("errors.messages.Book_was_failuer_updated.")
    end
  end

  def destroy
    if @book.destroy
      redirect_to books_url, notice: t("successfully.Book_was_successfully_destroyed.")
    else
      redirect_to @book, notice: t("errors.messages.Book_was_failuer_destroyed.")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_created_book
    @book = Book.find_by(id: params[:id], user_id: current_user)
  end

  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture, :user_id)
  end
end

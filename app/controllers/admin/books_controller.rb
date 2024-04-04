# frozen_string_literal: true

module Admin
  class BooksController < ApplicationController
    include Pagy::Backend

    before_action :set_book, only: [:edit, :update, :destroy]

    def index
      @pagy, @records = pagy(Book.order(title: :desc))
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)

      if @book.save
        redirect_to admin_books_path, notice: 'Book was successfully created.'
      else
        render :new
      end
    end


    def edit
    end

    def update
      if @book.update(book_params)
        redirect_to admin_books_path, notice: 'Book was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @book.destroy

      redirect_to admin_books_path, notice: 'Book was successfully destroyed.'
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end


    def book_params
      params
        .require(:book)
        .permit(:title, :author, :description, :price, :pages_number, :stock_quantity)
    end
  end
end

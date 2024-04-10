# frozen_string_literal: true

module Orders
  class BooksController < ApplicationController
    before_action :authenticate_user
    before_action :set_book, only: %i[create]

    def create
      if @book.stock_quantity > 0
        order.books << @book
      else
        turbo_flash_message('alert', 'This book is out of stock :(')
      end
    end

    def destroy
      order.orders_books.find_by!(book_id: params[:id]).destroy

      redirect_to cart_path, flash: { alert: 'Book removed' }
    end

    private

    def order
      @order ||= current_user.shopping_cart
    end

    def set_book
      @book = Book.find(params[:id])
    end
  end
end

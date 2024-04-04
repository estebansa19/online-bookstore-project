class ShoppingCarts::BooksController < ApplicationController
  before_action :authenticate_user
  before_action :set_book, only: %i[create]

  def create
    if @book.stock_quantity > 0
      shopping_cart.books << @book
    else
      turbo_flash_message('alert', 'This book is out of stock :(')
    end
  end

  def destroy
    shopping_cart.orders_books.find_by!(book_id: params[:id]).destroy

    redirect_to shopping_cart_path(shopping_cart), flash: { alert: 'Book removed' }
  end

  private

  def shopping_cart
    @shopping_cart ||= current_user.shopping_cart
  end

  def set_book
    @book = Book.find(params[:id])
  end
end

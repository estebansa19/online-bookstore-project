# frozen_string_literal: true

class ShoppingCartsController < ApplicationController
  before_action :authenticate_user
  before_action :set_shopping_cart, only: %i[show update]

  def show
    if @shopping_cart.user_id != current_user.id
      redirect_to root_path, flash: { alert: 'Unauthorized' }
    end
  end

  # The logic inside this action is really small but it should be in a service object, the model,
  # a PORO, etc.
  def update
    ActiveRecord::Base.transaction do
      @shopping_cart.books.each { |book| book.decrement!(:stock_quantity, 1) }
      @shopping_cart.completed!
    end

    redirect_to shopping_cart_path(@shopping_cart)
  rescue ActiveRecord::RecordInvalid
    render_flash_message('alert', 'Your purchase could not be processed')
  end

  private

  def set_shopping_cart
    @shopping_cart = Order.find(params[:id])
  end
end

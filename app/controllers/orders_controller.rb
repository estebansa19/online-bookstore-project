# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: %i[show update]

  def cart
    @shopping_cart = current_user.shopping_cart
  end

  def show
    if @order.user_id != current_user.id
      redirect_to root_path, flash: { alert: 'Unauthorized' }
    end
  end

  # The logic inside this action is really small but it should be in a service object, the model,
  # a PORO, etc.
  def update
    ActiveRecord::Base.transaction do
      @order.books.each { |book| book.decrement!(:stock_quantity, 1) }
      @order.completed!
    end

    redirect_to order_path(@order)
  rescue ActiveRecord::RecordInvalid
    render_flash_message('alert', 'Your purchase could not be processed')
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end

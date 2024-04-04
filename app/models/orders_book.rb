class OrdersBook < ApplicationRecord
  belongs_to :order
  belongs_to :book

  after_commit :update_order_price, on: [:create, :destroy]

  private

  def update_order_price
    total_price = order.books.sum(:price)
    order.update(total_price:)
  end
end

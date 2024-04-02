class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_books
  has_many :books, through: :orders_books

  validates :total_price, numericality: { greater_than: 0 }
end

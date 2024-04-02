class Book < ApplicationRecord
  validates :description, :title, presence: true
  validates :pages_number, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_books
  has_many :books, through: :orders_books

  enum status: { in_progress: 0, completed: 1 }

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, uniqueness: {
                      scope: :user_id,
                      conditions: -> { where(status: :in_progress) },
                      message: 'You already have an order in progress'
                    }, if: :in_progress?
end

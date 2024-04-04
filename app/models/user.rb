class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  validates :full_name, presence: true

  def shopping_cart
   @shopping_cart ||= orders.find_or_create_by(status: Order.statuses[:in_progress])
  end
end

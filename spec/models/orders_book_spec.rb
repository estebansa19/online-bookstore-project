require 'rails_helper'

RSpec.describe OrdersBook, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:book) }
  end

  describe 'callbacks.after_create' do
    it 'adds the price of the book to the order' do
      order = create(:order, total_price: 0)
      book = create(:book, price: 100)
      orders_book = create(:orders_book, order:, book:)

      expect(order.total_price).to eq(100)
    end
  end
end

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:total_price).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:orders_books) }
    it { should have_many(:books).through(:orders_books) }
  end
end

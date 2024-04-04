require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    subject { create(:order) }

    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }

    it 'validates uniqueness of user_id for in_progress status' do
      in_progress_order = create(:order)
      new_in_progress_order = build(:order)
      new_in_progress_order.user_id = in_progress_order.user_id
      new_in_progress_order.valid?

      expect(new_in_progress_order.errors[:status])
        .to include('You already have an order in progress')
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:orders_books) }
    it { should have_many(:books).through(:orders_books) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(in_progress: 0, completed: 1) }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:orders) }
  end

  describe '#shopping_cart' do
    let(:user) { create(:user) }

    context 'when the user has already accessed to his shopping cart' do
      before { user.shopping_cart }

      it 'does not change the number of orders' do
        expect { user.shopping_cart }.not_to change(Order.in_progress, :count)
      end
    end

    context 'when the user has not accessed to his shopping cart' do
      it 'creates a new Order with status in_progress' do
        expect { user.shopping_cart }.to change(Order.in_progress, :count).from(0).to(1)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:pages_number).only_integer.is_greater_than(0) }

    it do
      should validate_numericality_of(:stock_quantity).only_integer.is_greater_than_or_equal_to(0)
    end
  end
end

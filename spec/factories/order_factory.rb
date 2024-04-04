# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user
    total_price { Faker::Number.between(from: 50, to: 500) }
    status { :in_progress }
  end
end

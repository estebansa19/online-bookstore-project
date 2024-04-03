# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    description { Faker::Books::Lovecraft.sentence }
    title { Faker::Book.title }
    author { Faker::Book.author }
    pages_number { Faker::Number.between(from: 50, to: 500) }
    price { Faker::Number.between(from: 50, to: 200) }
    stock_quantity { Faker::Number.between(from: 10, to: 50) }
  end
end

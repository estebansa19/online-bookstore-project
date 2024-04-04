# frozen_string_literal: true

FactoryBot.define do
  factory :orders_book do
    book
    order
  end
end

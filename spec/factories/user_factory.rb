# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    password { '!Test123' }
    password_confirmation { '!Test123' }
    admin { false }
  end
end

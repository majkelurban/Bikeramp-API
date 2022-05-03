# frozen_string_literal: true

FactoryBot.define do
  factory :trip do
    start_address { "Skarżynskiego 4, Świdnik, Polska" }
    end_address   { "Grzybowska 62, Warszawa, Polska" }
    price         { Faker::Number.decimal(l_digits: 2) }
    delivery_date { "2022-05-03" }
    distance      { Faker::Number.decimal(l_digits: 2) }
    user          { create(:user) }
  end
end

# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_objects_pep, class: Tangany::Customers::Pep do
    initialize_with { new(attributes) }

    isExposed { [true, false].sample }
    checkDate { Faker::Date.backward(days: 365 * 5).to_s }
    source { Faker::Company.name }
    reason { |obj| obj.isExposed ? Faker::Lorem.sentence : nil }
    isSanctioned { |obj| obj.isExposed ? [true, false].sample : false }
  end
end

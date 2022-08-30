# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_document, class: Tangany::Customers::Document do
    initialize_with { new(attributes) }

    country { Faker::Address.country_code }
    nationality { Faker::Address.country_code }
    number { Faker::IDNumber.valid }
    issuedBy { Faker::Company.name }
    issueDate { Faker::Date.backward(days: 365 * 5).to_s }
    validUntil { |obj| Date.parse(obj.issueDate).next_year(10).to_s }
    type { Tangany::Customers::Document::ALLOWED_TYPES.sample }
  end
end

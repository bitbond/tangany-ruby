# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_contract, class: Tangany::Customers::Contract do
    initialize_with { new(attributes) }

    isSigned { [true, false].sample }
    signedDate { Faker::Date.backward(days: 365 * 5).to_s }
    isCancelled { [true, false].sample }
    cancelledDate { |obj| obj.isCancelled ? Faker::Date.between(from: obj.signedDate, to: Date.today).to_s : nil }
  end
end

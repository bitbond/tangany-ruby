require "factory_bot"

FactoryBot.define do
  factory :customers_objects_pep, class: "Tangany::Customers::Pep" do
    initialize_with { new(attributes) }

    isExposed { Faker::Boolean.boolean }
    checkDate { Faker::Date.backward(days: 365 * 5).to_s }
    source { Faker::Company.name }
    reason { |obj| obj.isExposed ? Faker::Lorem.sentence : nil }
    isSanctioned { |obj| obj.isExposed ? Faker::Boolean.boolean : false }
  end
end

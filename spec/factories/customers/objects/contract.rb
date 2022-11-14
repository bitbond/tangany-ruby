FactoryBot.define do
  factory :customers_objects_contract, class: "Tangany::Customers::Contract" do
    initialize_with { new(attributes) }

    type { Tangany::Customers::Contract::ALLOWED_TYPES.sample }
    signedDate { Faker::Date.backward(days: 365 * 5).to_s }

    trait :cancelled do
      cancelledDate { |obj| Faker::Date.between(from: obj.signedDate, to: Date.today).to_s }
    end
  end
end

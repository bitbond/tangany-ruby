FactoryBot.define do
  factory :customers_objects_pep, class: "Tangany::Customers::Pep" do
    initialize_with { new(attributes) }

    checkDate { Faker::Time.backward(days: 365).utc.iso8601(3) }
    isExposed { false }

    trait :exposed do
      isExposed { true }
      source { Faker::Company.name }
      reason { Faker::Lorem.sentence }
    end
  end
end

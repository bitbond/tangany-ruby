FactoryBot.define do
  factory :customers_objects_sanctions, class: "Tangany::Customers::Sanctions" do
    initialize_with { new(attributes) }

    checkDate { Faker::Time.backward(days: 365).utc.iso8601(3) }
    isSanctioned { false }

    trait :sanctioned do
      isSanctioned { true }
      source { Faker::Company.name }
      reason { Faker::Lorem.sentence }
    end
  end
end

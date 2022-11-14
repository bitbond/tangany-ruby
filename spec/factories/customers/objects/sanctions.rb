FactoryBot.define do
  factory :customers_objects_sanctions, class: "Tangany::Customers::Sanctions" do
    initialize_with { new(attributes) }

    checkDate { Faker::Date.backward(days: 365).to_s }
    isSanctioned { Faker::Boolean.boolean }
    source { |obj| obj.isSanctioned ? Faker::Company.name : nil }
    reason { |obj| obj.isSanctioned ? Faker::Lorem.sentence : nil }

    trait :sanctioned do
      isSanctioned { true }
      source { Faker::Company.name }
      reason { Faker::Lorem.sentence }
    end

    trait :not_sanctioned do
      isSanctioned { false }
    end
  end
end

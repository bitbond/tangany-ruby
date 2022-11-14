FactoryBot.define do
  factory :customers_objects_kyc, class: "Tangany::Customers::Kyc" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    date { Faker::Date.backward(days: 365).to_s }
    add_attribute(:method) { Tangany::Customers::Kyc::ALLOWED_METHODS.sample }
    association :document, factory: :customers_objects_document
  end
end

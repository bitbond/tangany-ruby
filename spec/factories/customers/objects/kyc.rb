FactoryBot.define do
  factory :customers_objects_kyc, class: "Tangany::Customers::Kyc" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    date { Faker::Time.backward(days: 365).utc.iso8601(3) }
    add_attribute(:method) { Tangany::Customers::Kyc::ALLOWED_METHODS.sample }
    document { association(:customers_objects_document) }
  end
end

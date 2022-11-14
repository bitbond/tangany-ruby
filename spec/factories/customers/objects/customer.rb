FactoryBot.define do
  factory :customers_objects_customer, class: "Tangany::Customers::Customer" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    owner { {entityId: Faker::Internet.uuid} }
    authorized { {entityId: Faker::Internet.uuid} }
    contracts { [association(:customers_objects_contract)] }
    additionalAttributes { {"foo" => "bar"} }
  end
end

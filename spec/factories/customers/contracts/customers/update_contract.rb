FactoryBot.define do
  factory :customers_contracts_customers_update, class: "Tangany::Customers::Contracts::Customers::Update" do
    initialize_with { new.to_safe_params!(attributes) }

    id { Faker::Internet.uuid }
    owner { {entityId: Faker::Internet.uuid} }
    authorized { [{entityId: Faker::Internet.uuid}] }
    contracts {
      [{
        type: "standard",
        signedDate: Faker::Date.backward(days: 365 * 5).to_s
      }]
    }
  end
end

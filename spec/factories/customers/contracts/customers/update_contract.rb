require "factory_bot"

FactoryBot.define do
  factory :customers_contracts_customers_update, class: "Tangany::Customers::Contracts::Customers::Update" do
    initialize_with { new.to_safe_params!(attributes) }

    contract do
      {
        isSigned: true,
        signedDate: Date.today.to_s
      }
    end
  end
end

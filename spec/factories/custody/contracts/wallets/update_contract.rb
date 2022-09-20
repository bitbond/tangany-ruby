require "factory_bot"

FactoryBot.define do
  factory :custody_contracts_wallets_update, class: "Tangany::Custody::Wallets::UpdateContract" do
    initialize_with { new.to_safe_params!(attributes) }

    tags do
      [{
        tag1: Faker::Lorem.characters(number: 256)
      }]
    end
  end
end

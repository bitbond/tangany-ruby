FactoryBot.define do
  factory :custody_contracts_wallets_create, class: "Tangany::Custody::Contracts::Wallets::Create" do
    initialize_with { new.to_safe_params!(attributes) }

    wallet { Faker::Internet.uuid }
    useHsm { Faker::Boolean.boolean }
    tags do
      [{
        tag1: Faker::Lorem.characters(number: 256)
      }]
    end
  end
end

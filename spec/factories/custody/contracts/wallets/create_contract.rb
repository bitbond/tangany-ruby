FactoryBot.define do
  factory :custody_contracts_wallets_create, class: "Tangany::Custody::Contracts::Wallets::Create" do
    initialize_with { new.to_safe_params!(attributes) }

    wallet { "wallet-#{Faker::Lorem.words(number: 5).join("-")}" }
    useHsm { false }
    tags do
      [{
        tag1: Faker::Lorem.word
      }]
    end
  end
end

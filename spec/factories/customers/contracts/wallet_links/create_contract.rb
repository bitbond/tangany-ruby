FactoryBot.define do
  factory :customers_contracts_wallet_links_create, class: "Tangany::Customers::Contracts::WalletLinks::Create" do
    initialize_with { new.to_safe_params!(attributes) }

    id { Faker::Internet.uuid }
    address { Faker::Blockchain::Ethereum.address }
    assetId { Tangany::Customers::WalletLink::ALLOWED_CHAIN_IDS.sample }
    assignment do
      {
        customerId: Faker::Internet.uuid
      }
    end
  end
end

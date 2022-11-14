FactoryBot.define do
  factory :customers_contracts_wallet_links_create, class: "Tangany::Customers::Contracts::WalletLinks::Create" do
    initialize_with { new.to_safe_params!(attributes) }

    id { Faker::Internet.uuid }
    type { Tangany::Customers::Contracts::WalletLinks::Create::ALLOWED_TYPES.sample }
    vaultUrl { Faker::Internet.url }
    vaultWalletId { Faker::Internet.uuid }
    assignment do
      {
        customerId: Faker::Internet.uuid
      }
    end
  end
end

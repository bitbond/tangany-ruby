require "factory_bot"

FactoryBot.define do
  factory :customers_contracts_wallet_links_create, class: "Tangany::Customers::WalletLinks::CreateContract" do
    initialize_with { new.call(attributes) }

    id { Faker::Internet.uuid }
    type { Tangany::Customers::WalletLinks::CreateContract::ALLOWED_TYPES.sample }
    vaultUrl { Faker::Internet.url }
    vaultWalletId { Faker::Internet.uuid }
    assignment do
      {
        customerId: Faker::Internet.uuid
      }
    end
  end
end

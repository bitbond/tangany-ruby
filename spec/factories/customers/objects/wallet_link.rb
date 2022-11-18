FactoryBot.define do
  factory :customers_objects_wallet_link, class: "Tangany::Customers::WalletLink" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    address { Faker::Blockchain::Ethereum.address }
    assetId { Tangany::Customers::WalletLink::ALLOWED_ASSET_IDS.sample }
    assignment do
      {
        customerId: Faker::Internet.uuid
      }
    end
  end
end

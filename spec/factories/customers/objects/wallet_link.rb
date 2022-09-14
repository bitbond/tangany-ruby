require "factory_bot"

FactoryBot.define do
  factory :customers_objects_wallet_link, class: "Tangany::Customers::WalletLink" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    type { Tangany::Customers::WalletLinks::CreateContract::ALLOWED_TYPES.sample }
    assignment do
      {
        customerId: Faker::Internet.uuid
      }
    end
  end
end

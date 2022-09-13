# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_inputs_wallet_links_create, class: "Tangany::Customers::WalletLinks::CreateInput" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    type { Tangany::Customers::WalletLinks::CreateInput::ALLOWED_TYPES.sample }
    vaultUrl { Faker::Internet.url }
    vaultWalletId { Faker::Internet.uuid }
    assignment do
      {
        customerId: Faker::Internet.uuid
      }
    end
  end
end

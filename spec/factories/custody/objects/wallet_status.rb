FactoryBot.define do
  factory :custody_objects_wallet_status, class: "Tangany::Custody::WalletStatus" do
    initialize_with { new(attributes) }

    address { Faker::Blockchain::Ethereum.address }
    balance { Faker::Number.decimal(l_digits: 10, r_digits: 8).to_s }
    currency { "ETH" }
    nonce { Faker::Number.number(digits: 10) }
  end
end

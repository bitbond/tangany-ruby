FactoryBot.define do
  factory :custody_objects_wallet, class: "Tangany::Custody::Wallet" do
    initialize_with { new(attributes) }

    wallet { Faker::Internet.uuid }
    version { "latest" }
    created { Faker::Time.backward(days: 14, period: :morning).utc.iso8601(3) }
    updated { |obj| Faker::Time.between(from: Time.parse(obj.created), to: DateTime.now).utc.iso8601(3) }
    security { ["hsm", "software"].sample }
    add_attribute(:public) { {secp256k1: Faker::Number.hexadecimal(digits: 130)} }
    tags { [] }
  end
end

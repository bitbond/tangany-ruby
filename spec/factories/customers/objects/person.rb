require "factory_bot"

FactoryBot.define do
  factory :customers_objects_person, class: "Tangany::Customers::Person" do
    initialize_with { new(attributes) }

    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    gender { Tangany::Customers::Customers::CreateContract::ALLOWED_PERSON_GENDERS.sample }
    birthDate { Faker::Date.birthday(min_age: 18, max_age: 65).to_s }
    birthName { Faker::Name.first_name }
    birthPlace { Faker::Address.city }
    birthCountry { Faker::Address.country_code }
    nationality { Faker::Address.country_code }
    association :address, factory: :customers_objects_address
    email { Faker::Internet.email }
    association :kyc, factory: :customers_objects_kyc
    association :pep, factory: :customers_objects_pep
  end
end

FactoryBot.define do
  factory :customers_objects_natural_person, class: "Tangany::Customers::NaturalPerson" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    gender { Tangany::Customers::NaturalPerson::ALLOWED_GENDERS.sample }
    birthDate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    birthPlace { Faker::Address.city }
    birthCountry { Faker::Address.country_code }
    birthName { Faker::Name.first_name }
    nationality { Faker::Address.country_code }
    address { association(:customers_objects_address) }
    email { Faker::Internet.email }
    kyc { association(:customers_objects_kyc) }
    pep { association(:customers_objects_pep) }
    sanctions { association(:customers_objects_sanctions) }
  end
end

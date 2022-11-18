FactoryBot.define do
  factory :customers_contracts_natural_persons_update, class: "Tangany::Customers::Contracts::NaturalPersons::Update" do
    initialize_with { new.to_safe_params!(attributes) }

    birth_date = Faker::Date.birthday(min_age: 18, max_age: 65)
    issue_date = Faker::Date.between(from: birth_date.next_year(18), to: Date.today)

    id { Faker::Internet.uuid }
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    gender { Tangany::Customers::NaturalPerson::ALLOWED_GENDERS.sample }
    birthDate { birth_date.to_s }
    birthPlace { Faker::Address.city }
    birthCountry { Faker::Address.country_code }
    birthName { Faker::Name.first_name }
    nationality { Faker::Address.country_code }
    address {
      {
        country: Faker::Address.country_code,
        city: Faker::Address.city,
        postcode: Faker::Address.postcode,
        streetName: Faker::Address.street_name,
        streetNumber: Faker::Address.building_number
      }
    }
    email { Faker::Internet.email }
    kyc {
      {
        id: Faker::Internet.uuid,
        date: Faker::Time.between(from: issue_date, to: Time.now).utc.iso8601(3),
        method: Tangany::Customers::Kyc::ALLOWED_METHODS.sample,
        document: {
          country: Faker::Address.country_code,
          nationality: Faker::Address.country_code,
          number: Faker::IDNumber.valid,
          issuedBy: Faker::Company.name,
          issueDate: issue_date.to_s,
          validUntil: issue_date.next_year(10).to_s,
          type: Tangany::Customers::Document::ALLOWED_TYPES.sample
        }
      }
    }
    pep {
      {
        checkDate: Faker::Time.between(from: issue_date, to: Time.now).utc.iso8601(3),
        isExposed: false
      }
    }
    sanctions {
      {
        checkDate: Faker::Time.between(from: issue_date, to: Time.now).utc.iso8601(3),
        isSanctioned: false
      }
    }

    trait :is_exposed do
      pep {
        {
          checkDate: Faker::Time.between(from: issue_date, to: Time.now).utc.iso8601(3),
          isExposed: true,
          source: Faker::Company.name,
          reason: Faker::Lorem.sentence
        }
      }
    end

    trait :is_sanctioned do
      sanctions {
        {
          checkDate: Faker::Time.between(from: issue_date, to: Time.now).utc.iso8601(3),
          isSanctioned: true,
          source: Faker::Company.name,
          reason: Faker::Lorem.sentence
        }
      }
    end
  end
end

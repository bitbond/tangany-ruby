require "factory_bot"

FactoryBot.define do
  factory :customers_contracts_customers_create, class: "Tangany::Customers::Contracts::Customers::Create" do
    initialize_with { new.to_safe_params!(attributes) }

    id { Faker::Internet.uuid }
    environment { "testing" }
    naturalPerson do
      is_exposed = Faker::Boolean.boolean
      is_sanctioned = Faker::Boolean.boolean
      issue_date = Faker::Date.backward(days: 365 * 5).to_s
      {
        id: Faker::Internet.uuid,
        title: Faker::Name.prefix,
        firstName: Faker::Name.first_name,
        lastName: Faker::Name.last_name,
        gender: Tangany::Customers::NaturalPerson::ALLOWED_GENDERS.sample,
        birthDate: Faker::Date.birthday(min_age: 18, max_age: 65).to_s,
        birthPlace: Faker::Address.city,
        birthCountry: Faker::Address.country_code,
        birthName: Faker::Name.first_name,
        nationality: Faker::Address.country_code,
        address: {
          country: Faker::Address.country_code,
          city: Faker::Address.city,
          postcode: Faker::Address.postcode,
          streetName: Faker::Address.street_name,
          streetNumber: Faker::Address.building_number
        },
        email: Faker::Internet.email,
        kyc: {
          id: Faker::Internet.uuid,
          date: Faker::Date.backward(days: 365).to_s,
          method: Tangany::Customers::Kyc::ALLOWED_METHODS.sample,
          document: {
            country: Faker::Address.country_code,
            nationality: Faker::Address.country_code,
            number: Faker::IDNumber.valid,
            issuedBy: Faker::Company.name,
            issueDate: issue_date,
            validUntil: Date.parse(issue_date).next_year(10).to_s,
            type: Tangany::Customers::Kyc::ALLOWED_DOCUMENT_TYPES.sample
          }
        },
        pep: {
          isExposed: is_exposed,
          checkDate: Faker::Date.backward(days: 365 * 5).to_s,
          source: is_exposed ? Faker::Company.name : nil,
          reason: is_exposed ? Faker::Lorem.sentence : nil,
          isSanctioned: is_sanctioned
        },
        sanctions: {
          checkDate: Faker::Time.backward(days: 365).utc.iso8601,
          isSanctioned: is_sanctioned,
          source: is_sanctioned ? Faker::Company.name : nil,
          reason: is_sanctioned ? Faker::Lorem.sentence : nil
        }
      }
    end
    contract do
      is_cancelled = Faker::Boolean.boolean
      is_signed = Faker::Boolean.boolean
      signed_date = Faker::Date.backward(days: 365 * 5).to_s
      {
        isSigned: is_signed,
        signedDate: is_signed ? signed_date : nil,
        isCancelled: is_cancelled,
        cancelledDate: is_cancelled ? Faker::Date.between(from: signed_date, to: Date.today).to_s : nil
      }
    end
  end
end

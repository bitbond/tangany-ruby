# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_inputs_customers_create, class: "Tangany::Customers::Customers::CreateInput" do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    person do
      is_exposed = Faker::Boolean.boolean
      issue_date = Faker::Date.backward(days: 365 * 5).to_s
      {
        firstName: Faker::Name.first_name,
        lastName: Faker::Name.last_name,
        gender: Tangany::Customers::Customers::CreateInput::ALLOWED_PERSON_GENDERS.sample,
        birthDate: Faker::Date.birthday(min_age: 18, max_age: 65).to_s,
        birthName: Faker::Name.first_name,
        birthPlace: Faker::Address.city,
        birthCountry: Faker::Address.country_code,
        nationality: Faker::Address.country_code,
        address: {
          country: Faker::Address.country_code,
          city: Faker::Address.city,
          postcode: Faker::Address.postcode,
          streetName: Faker::Address.street_name,
          streetNumber: Faker::Address.building_number,
        },
        email: Faker::Internet.email,
        kyc: {
          id: Faker::Internet.uuid,
          date: Faker::Date.backward(days: 365).to_s,
          method: Tangany::Customers::Customers::CreateInput::ALLOWED_PERSON_KYC_METHODS.sample,
          document: {
            country: Faker::Address.country_code,
            nationality: Faker::Address.country_code,
            number: Faker::IDNumber.valid,
            issuedBy: Faker::Company.name,
            issueDate: issue_date,
            validUntil: Date.parse(issue_date).next_year(10).to_s,
            type: Tangany::Customers::Customers::CreateInput::ALLOWED_PERSON_KYC_DOCUMENT_TYPES.sample,
          },
        },
        pep: {
          isExposed: is_exposed,
          checkDate: Faker::Date.backward(days: 365 * 5).to_s,
          source: Faker::Company.name,
          reason: is_exposed ? Faker::Lorem.sentence : nil,
          isSanctioned: is_exposed ? Faker::Boolean.boolean : false,
        },
      }
    end
    contract do
      is_cancelled = Faker::Boolean.boolean
      signed_date = Faker::Date.backward(days: 365 * 5).to_s
      {
        isSigned: Faker::Boolean.boolean,
        signedDate: signed_date,
        isCancelled: is_cancelled,
        cancelledDate: is_cancelled ? Faker::Date.between(from: signed_date, to: Date.today).to_s : nil,
      }
    end
    additional_attributes { Faker::Internet.user }
  end
end

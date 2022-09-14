require "factory_bot"

FactoryBot.define do
  factory :customers_objects_address, class: "Tangany::Customers::Address" do
    initialize_with { new(attributes) }

    country { Faker::Address.country_code }
    city { Faker::Address.city }
    postcode { Faker::Address.postcode }
    streetName { Faker::Address.street_name }
    streetNumber { Faker::Address.building_number }
  end
end

# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_objects_customer, class: Tangany::Customers::Customer do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    association :person, factory: :customers_objects_person
    association :contract, factory: :customers_objects_contract
    additional_attributes { Faker::Internet.user }
    add_attribute(:_links) { |obj| { documents: "/customers/#{obj.id}/documents" } }
  end
end

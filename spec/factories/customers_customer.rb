# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_customer, class: Tangany::Customers::Customer do
    initialize_with { new(attributes) }

    id { Faker::Internet.uuid }
    association :person, factory: :customers_person
    association :contract, factory: :customers_contract
    additional_attributes { Faker::Internet.user }
    add_attribute(:_links) { |obj| { documents: "/customers/#{obj.id}/documents" } }
  end
end

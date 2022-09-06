# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_bodies_customers_update, class: Tangany::Customers::Customers::UpdateBody do
    initialize_with { new(attributes) }

    operations do
      [{
        op: "replace",
        path: "/contract/isSigned",
        value: true,
      }, {
        op: "replace",
        path: "/contract/signedAt",
        value: Date.today.to_s,
      },]
    end
  end
end

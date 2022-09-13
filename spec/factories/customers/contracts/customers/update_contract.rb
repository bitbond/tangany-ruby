# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_contracts_customers_update, class: "Tangany::Customers::Customers::UpdateContract" do
    initialize_with { new(attributes) }

    contract do
      {
        isSigned: true,
        signedDate: Date.today.to_s
      }
    end
  end
end
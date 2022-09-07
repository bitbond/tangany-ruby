# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :customers_inputs_customers_update, class: "Tangany::Customers::Customers::UpdateInput" do
    initialize_with { new(attributes) }

    contract do
      {
        isSigned: true,
        signedDate: Date.today.to_s
      }
    end
  end
end

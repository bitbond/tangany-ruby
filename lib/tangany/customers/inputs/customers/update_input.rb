# frozen_string_literal: true

module Tangany
  module Customers
    module Customers
      class UpdateInput < Input
        attribute :person, Dry::Struct.meta(omittable: true) do
          attribute :lastName?, Types::String.constrained(max_size: 50)
          attribute :address, Dry::Struct.meta(omittable: true) do
            attribute :country?, Types::String.constrained(format: COUNTRY_REGEXP)
            attribute :city?, Types::String.constrained(max_size: 50)
            attribute :postcode?, Types::String.constrained(max_size: 50)
            attribute :streetName?, Types::String.constrained(max_size: 50)
            attribute :streetNumber?, Types::String.constrained(max_size: 50)
          end
          attribute :email?, Types::String.constrained(max_size: 255)
          attribute :pep, Dry::Struct.meta(omittable: true) do
            attribute :isExposed?, Types::Bool
            attribute :checkDate?, Types::String.constrained(format: DATE_REGEXP)
            attribute :source?, Types::String.constrained(max_size: 255).optional
            attribute :reason?, Types::String.optional
            attribute :isSanctioned?, Types::Bool
          end
        end
        attribute :contract, Dry::Struct.meta(omittable: true) do
          attribute :isSigned?, Types::Bool
          attribute :signedDate?, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP).optional
          attribute :isCancelled?, Types::Bool
          attribute :cancelledDate?, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP).optional
        end
        attribute :additional_attributes?, Types::Hash
      end
    end
  end
end

require_relative "create_schemas/natural_person"

module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        class Create < ApplicationContract
          schema(CreateSchemas::NaturalPerson.schema) { config.validate_keys = true }

          rule(pep: :source) do
            key.failure("must be present if pep.isExposed is true") if values.dig(:pep, :isExposed) && !value
            key.failure("must not be present if pep.isExposed is false") if !values.dig(:pep, :isExposed) && value
          end

          rule(sanctions: :source) do
            key.failure("must be present if sanctions.isSanctioned is true") if values.dig(:sanctions, :isSanctioned) && !value
            key.failure("must not be present if sanctions.isSanctioned is false") if !values.dig(:sanctions, :isSanctioned) && value
          end
        end
      end
    end
  end
end

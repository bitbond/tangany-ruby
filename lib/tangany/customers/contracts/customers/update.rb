require_relative "update_schemas/contract"
require_relative "update_schemas/person"

module Tangany
  module Customers
    module Contracts
      module Customers
        class Update < ApplicationContract
          schema do
            config.validate_keys = true

            optional(:contract).hash(UpdateSchemas::Contract.schema)
            optional(:person).hash(UpdateSchemas::Person.schema)
            # TODO: Add support for company
          end

          rule(person: {pep: :source}) do
            if values.dig(:person, :pep, :source).present? && !values.dig(:person, :pep, :isExposed)
              key.failure("should be specified only if `person.pep.isExposed` is true")
            end
          end

          rule(person: {pep: :reason}) do
            if values.dig(:person, :pep, :reason).present? && !values.dig(:person, :pep, :isExposed)
              key.failure("should be specified only if `person.pep.isExposed` is true")
            end
          end
        end
      end
    end
  end
end

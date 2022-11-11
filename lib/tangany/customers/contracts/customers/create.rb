require_relative "create_schemas/contract"
require_relative "create_schemas/natural_person"

module Tangany
  module Customers
    module Contracts
      module Customers
        class Create < ApplicationContract
          schema do
            config.validate_keys = true

            required(:id).filled(:string)
            required(:naturalPerson).hash(CreateSchemas::NaturalPerson.schema)
            # TODO: Add support for company
            required(:contract).hash(CreateSchemas::Contract.schema)
          end

          rule(contract: :cancelledDate) do
            if values[:contract][:cancelledDate].present? && !values[:contract][:isCancelled]
              key.failure("should be specified only if `contract.isCancelled` is true")
            end
          end

          rule(naturalPerson: {pep: :source}) do
            if values.dig(:naturalPerson, :pep, :source).present? && !values.dig(:naturalPerson, :pep, :isExposed)
              key.failure("should be specified only if `naturalPerson.pep.isExposed` is true")
            end
          end

          rule(naturalPerson: {pep: :reason}) do
            if values.dig(:naturalPerson, :pep, :reason).present? && !values.dig(:naturalPerson, :pep, :isExposed)
              key.failure("should be specified only if `naturalPerson.pep.isExposed` is true")
            end
          end

          rule(naturalPerson: {sanctions: :source}) do
            if values.dig(:naturalPerson, :sanctions, :source).present? && !values.dig(:naturalPerson, :sanctions, :isSanctioned)
              key.failure("should be specified only if `naturalPerson.sanctions.isSanctioned` is true")
            end
          end

          rule(naturalPerson: {sanctions: :reason}) do
            if values.dig(:naturalPerson, :sanctions, :reason).present? && !values.dig(:naturalPerson, :sanctions, :isSanctioned)
              key.failure("should be specified only if `naturalPerson.sanctions.isSanctioned` is true")
            end
          end
        end
      end
    end
  end
end

require_relative "create_schemas/contract"
require_relative "create_schemas/person"

module Tangany
  module Customers
    module Contracts
      module Customers
        class Create < ApplicationContract
          ALLOWED_PERSON_GENDERS = ["F", "M", "X"].freeze
          ALLOWED_PERSON_KYC_DOCUMENT_TYPES = ["id_card", "passport"].freeze
          ALLOWED_PERSON_KYC_METHODS = ["video_ident", "id_copy", "auto_ident", "in_person", "no_verification"].freeze

          schema do
            config.validate_keys = true

            required(:id).filled(:string)
            required(:environment).filled(:string, included_in?: ALLOWED_ENVIRONMENTS)
            required(:person).hash(CreateSchemas::Person.schema)
            # TODO: Add support for company
            required(:contract).hash(CreateSchemas::Contract.schema)
          end

          rule(contract: :cancelledDate) do
            if values[:contract][:cancelledDate].present? && !values[:contract][:isCancelled]
              key.failure("should be specified only if `contract.isCancelled` is true")
            end
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

module Tangany
  module Customers
    module Contracts
      module Customers
        class Create < ApplicationContract
          ALLOWED_PERSON_GENDERS = ["F", "M", "X"].freeze
          ALLOWED_PERSON_KYC_DOCUMENT_TYPES = ["id_card", "passport"].freeze
          ALLOWED_PERSON_KYC_METHODS = ["video_ident", "id_copy", "auto_ident", "in_person", "no_verification"].freeze

          AddressSchema = Dry::Schema.Params do
            required(:country).filled(:string, format?: COUNTRY_REGEXP)
            required(:city).filled(:string, max_size?: 50)
            required(:postcode).filled(:string, max_size?: 50)
            required(:streetName).filled(:string, max_size?: 50)
            required(:streetNumber).filled(:string, max_size?: 50)
          end

          ContractSchema = Dry::Schema.Params do
            required(:isSigned).filled(:bool)
            required(:signedDate).maybe(:string, format?: DATETIME_OPTIONAL_REGEXP)
            optional(:isCancelled).filled(:bool)
            optional(:cancelledDate).maybe(:string, format?: DATETIME_OPTIONAL_REGEXP)
          end

          DocumentSchema = Dry::Schema.Params do
            required(:country).filled(:string, format?: COUNTRY_REGEXP)
            required(:nationality).filled(:string, format?: COUNTRY_REGEXP)
            required(:number).filled(:string, max_size?: 50)
            required(:issuedBy).filled(:string, max_size?: 50)
            required(:issueDate).filled(:string, format?: DATE_REGEXP)
            required(:validUntil).filled(:string, format?: DATE_REGEXP)
            required(:type).filled(:string, included_in?: ALLOWED_PERSON_KYC_DOCUMENT_TYPES)
          end

          KycSchema = Dry::Schema.Params do
            required(:id).filled(:string, max_size?: 150)
            required(:date).filled(:string, format?: DATETIME_OPTIONAL_REGEXP)
            required(:method).filled(:string, included_in?: ALLOWED_PERSON_KYC_METHODS)
            required(:document).hash(DocumentSchema)
          end

          PepSchema = Dry::Schema.Params do
            required(:isExposed).filled(:bool)
            required(:checkDate).filled(:string, format?: DATE_REGEXP)
            required(:source).maybe(:string, max_size?: 255)
            optional(:reason).maybe(:string)
            required(:isSanctioned).filled(:bool)
          end

          PersonSchema = Dry::Schema.Params do
            required(:firstName).filled(:string, max_size?: 50)
            required(:lastName).filled(:string, max_size?: 50)
            required(:gender).filled(:string, included_in?: ALLOWED_PERSON_GENDERS)
            required(:birthDate).filled(:string, format?: DATE_REGEXP)
            required(:birthName).filled(:string, max_size?: 50)
            required(:birthPlace).filled(:string, max_size?: 50)
            required(:birthCountry).filled(:string, format?: COUNTRY_REGEXP)
            required(:nationality).filled(:string, format?: COUNTRY_REGEXP)
            required(:address).hash(AddressSchema)
            required(:email).filled(:string, max_size?: 255)
            required(:kyc).hash(KycSchema)
            required(:pep).hash(PepSchema)
          end

          schema do
            config.validate_keys = true

            required(:id).filled(:string)
            required(:environment).filled(:string, included_in?: ALLOWED_ENVIRONMENTS)
            required(:person).hash(PersonSchema)
            # TODO: Add support for company
            required(:contract).hash(ContractSchema)
          end

          rule(contract: :cancelledDate) do
            if values[:contract][:cancelledDate].present? && !values[:contract][:isCancelled]
              key.failure("should be specified only if `contract.isCancelled` is true")
            end
          end

          rule(person: {pep: :source}) do
            if values[:person][:pep][:source].present? && !values[:person][:pep][:isExposed]
              key.failure("should be specified only if `person.pep.isExposed` is true")
            end
          end
        end
      end
    end
  end
end

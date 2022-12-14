require_relative "address"
require_relative "kyc"
require_relative "pep"
require_relative "sanctions"

module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        module CreateSchemas
          module NaturalPerson
            module ClassMethods
              def schema
                Dry::Schema.Params do
                  required(:id).filled(:string, max_size?: 40)
                  optional(:title).maybe(:string, max_size?: 255)
                  required(:firstName).filled(:string, max_size?: 255)
                  required(:lastName).filled(:string, max_size?: 255)
                  optional(:gender).maybe(:string, included_in?: Tangany::Customers::NaturalPerson::ALLOWED_GENDERS)
                  required(:birthDate).filled(:string, format?: Tangany::ApplicationContract::DATE_REGEX)
                  required(:birthPlace).filled(:string, max_size?: 255)
                  required(:birthCountry).filled(:string, format?: Tangany::ApplicationContract::COUNTRY_CODE_REGEX)
                  optional(:birthName).maybe(:string, max_size?: 255)
                  optional(:nationality).maybe(:string, format?: Tangany::ApplicationContract::COUNTRY_CODE_REGEX)
                  optional(:address).hash(Address.schema)
                  optional(:email).maybe(:string, max_size?: 255)
                  optional(:kyc).hash(Kyc.schema)
                  optional(:pep).hash(Pep.schema)
                  optional(:sanctions).hash(Sanctions.schema)
                end
              end
            end

            extend ClassMethods

            def self.included(base)
              base.extend(ClassMethods)
            end
          end
        end
      end
    end
  end
end

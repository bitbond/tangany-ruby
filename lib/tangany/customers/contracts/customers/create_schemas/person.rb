require_relative "address"
require_relative "kyc"
require_relative "pep"

module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Person
            class << self
              def schema
                Dry::Schema.Params do
                  required(:firstName).filled(:string, max_size?: 50)
                  required(:lastName).filled(:string, max_size?: 50)
                  required(:gender).filled(:string, included_in?: Create::ALLOWED_PERSON_GENDERS)
                  required(:birthDate).filled(:string, format?: Create::DATE_REGEXP)
                  required(:birthName).filled(:string, max_size?: 50)
                  required(:birthPlace).filled(:string, max_size?: 50)
                  required(:birthCountry).filled(:string, format?: Create::COUNTRY_REGEXP)
                  required(:nationality).filled(:string, format?: Create::COUNTRY_REGEXP)
                  required(:address).hash(Address.schema)
                  required(:email).filled(:string, max_size?: 255)
                  required(:kyc).hash(Kyc.schema)
                  required(:pep).hash(Pep.schema)
                end
              end
            end
          end
        end
      end
    end
  end
end

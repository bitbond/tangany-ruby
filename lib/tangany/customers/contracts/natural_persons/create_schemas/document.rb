module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        module CreateSchemas
          module Document
            class << self
              def schema
                Dry::Schema.Params do
                  required(:country).filled(:string, format?: Tangany::ApplicationContract::COUNTRY_CODE_REGEX)
                  required(:nationality).filled(:string, format?: Tangany::ApplicationContract::COUNTRY_CODE_REGEX)
                  required(:number).filled(:string, max_size?: 255)
                  required(:issuedBy).filled(:string, max_size?: 255)
                  required(:issueDate).filled(:string, format?: Tangany::ApplicationContract::DATE_REGEX)
                  required(:validUntil).filled(:string, format?: Tangany::ApplicationContract::DATE_REGEX)
                  required(:type).filled(:string, included_in?: Tangany::Customers::Document::ALLOWED_TYPES)
                end
              end
            end
          end
        end
      end
    end
  end
end

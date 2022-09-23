module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Document
            class << self
              def schema
                Dry::Schema.Params do
                  required(:country).filled(:string, format?: Create::COUNTRY_REGEXP)
                  required(:nationality).filled(:string, format?: Create::COUNTRY_REGEXP)
                  required(:number).filled(:string, max_size?: 50)
                  required(:issuedBy).filled(:string, max_size?: 50)
                  required(:issueDate).filled(:string, format?: Create::DATE_REGEXP)
                  required(:validUntil).filled(:string, format?: Create::DATE_REGEXP)
                  required(:type).filled(:string, included_in?: Create::ALLOWED_PERSON_KYC_DOCUMENT_TYPES)
                end
              end
            end
          end
        end
      end
    end
  end
end

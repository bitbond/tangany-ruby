module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Document
            class << self
              def schema
                Dry::Schema.Params do
                  required(:country).filled(:string, format?: ApplicationContract::COUNTRY_REGEXP)
                  required(:nationality).filled(:string, format?: ApplicationContract::COUNTRY_REGEXP)
                  required(:number).filled(:string, max_size?: 255)
                  required(:issuedBy).filled(:string, max_size?: 255)
                  required(:issueDate).filled(:string, format?: ApplicationContract::DATE_REGEXP)
                  required(:validUntil).filled(:string, format?: ApplicationContract::DATE_REGEXP)
                  required(:type).filled(:string, included_in?: Tangany::Customers::Kyc::ALLOWED_DOCUMENT_TYPES)
                end
              end
            end
          end
        end
      end
    end
  end
end

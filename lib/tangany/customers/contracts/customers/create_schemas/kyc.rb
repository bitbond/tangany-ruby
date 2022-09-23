require_relative "document"

module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Kyc
            class << self
              def schema
                Dry::Schema.Params do
                  required(:id).filled(:string, max_size?: 150)
                  required(:date).filled(:string, format?: Create::DATETIME_OPTIONAL_REGEXP)
                  required(:method).filled(:string, included_in?: Create::ALLOWED_PERSON_KYC_METHODS)
                  required(:document).hash(Document.schema)
                end
              end
            end
          end
        end
      end
    end
  end
end

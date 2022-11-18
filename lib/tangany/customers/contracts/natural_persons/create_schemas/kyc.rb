require_relative "document"

module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        module CreateSchemas
          module Kyc
            class << self
              def schema
                Dry::Schema.Params do
                  required(:id).filled(:string, max_size?: 255)
                  required(:date).filled(:string, format?: Tangany::ApplicationContract::DATE_REGEX)
                  required(:method).filled(:string, included_in?: Tangany::Customers::Kyc::ALLOWED_METHODS)
                  optional(:document).hash(Document.schema)
                end
              end
            end
          end
        end
      end
    end
  end
end

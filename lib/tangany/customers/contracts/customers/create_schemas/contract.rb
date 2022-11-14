module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Contract
            class << self
              def schema
                Dry::Schema.Params do
                  required(:type).filled(:string, included_in?: Tangany::Customers::Contract::ALLOWED_TYPES)
                  required(:signedDate).filled(:string, format?: ApplicationContract::DATE_REGEXP)
                  optional(:cancelledDate).filled(:string, format?: ApplicationContract::DATE_REGEXP)
                end
              end
            end
          end
        end
      end
    end
  end
end

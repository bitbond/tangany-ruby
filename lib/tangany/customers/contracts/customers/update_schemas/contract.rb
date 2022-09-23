module Tangany
  module Customers
    module Contracts
      module Customers
        module UpdateSchemas
          module Contract
            class << self
              def schema
                Dry::Schema.Params do
                  optional(:isSigned).filled(:bool)
                  optional(:signedDate).filled(:string, format?: Update::DATETIME_OPTIONAL_REGEXP)
                  optional(:isCancelled).filled(:bool)
                  optional(:cancelledDate).filled(:string, format?: Update::DATETIME_OPTIONAL_REGEXP)
                end
              end
            end
          end
        end
      end
    end
  end
end

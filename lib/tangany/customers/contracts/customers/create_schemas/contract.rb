module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Contract
            class << self
              def schema
                Dry::Schema.Params do
                  required(:isSigned).filled(:bool)
                  optional(:signedDate).maybe(:string, format?: Create::DATETIME_OPTIONAL_REGEXP)
                  required(:isCancelled).filled(:bool)
                  optional(:cancelledDate).maybe(:string, format?: Create::DATETIME_OPTIONAL_REGEXP)
                end
              end
            end
          end
        end
      end
    end
  end
end

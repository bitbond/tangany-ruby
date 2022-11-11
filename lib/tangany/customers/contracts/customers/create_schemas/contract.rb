module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Contract
            module ClassMethods
              def schema
                Dry::Schema.Params do
                  required(:isSigned).filled(:bool)
                  optional(:signedDate).maybe(:string, format?: ApplicationContract::DATETIME_OPTIONAL_REGEXP)
                  required(:isCancelled).filled(:bool)
                  optional(:cancelledDate).maybe(:string, format?: ApplicationContract::DATETIME_OPTIONAL_REGEXP)
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

module Tangany
  module Customers
    module Contracts
      module Customers
        module UpdateSchemas
          module Pep
            class << self
              def schema
                Dry::Schema.Params do
                  optional(:isExposed).filled(:bool)
                  optional(:checkDate).filled(:string, format?: Update::DATE_REGEXP)
                  optional(:source).maybe(:string, max_size?: 255)
                  optional(:reason).maybe(:string)
                  optional(:isSanctioned).filled(:bool)
                end
              end
            end
          end
        end
      end
    end
  end
end

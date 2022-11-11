module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Sanctions
            class << self
              def schema
                Dry::Schema.Params do
                  required(:checkDate).filled(:string, format?: ApplicationContract::DATE_REGEXP)
                  required(:isSanctioned).filled(:bool)
                  optional(:source).maybe(:string, max_size?: 255)
                  optional(:reason).maybe(:string, max_size?: 255)
                end
              end
            end
          end
        end
      end
    end
  end
end

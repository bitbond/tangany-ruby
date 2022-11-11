module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Pep
            class << self
              def schema
                Dry::Schema.Params do
                  required(:isExposed).filled(:bool)
                  required(:checkDate).filled(:string, format?: ApplicationContract::DATE_REGEXP)
                  required(:source).maybe(:string, max_size?: 255)
                  optional(:reason).maybe(:string)
                end
              end
            end
          end
        end
      end
    end
  end
end

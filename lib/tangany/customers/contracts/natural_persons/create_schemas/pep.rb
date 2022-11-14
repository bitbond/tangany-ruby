module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        module CreateSchemas
          module Pep
            class << self
              def schema
                Dry::Schema.Params do
                  required(:checkDate).filled(:string, format?: Tangany::ApplicationContract::DATETIME_REGEX)
                  required(:isExposed).filled(:bool)
                  optional(:source).filled(:string, max_size?: 255)
                  optional(:reason).filled(:string, max_size?: 255)
                end
              end
            end
          end
        end
      end
    end
  end
end

module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        module CreateSchemas
          module Address
            class << self
              def schema
                Dry::Schema.Params do
                  required(:country).filled(:string, format?: Tangany::ApplicationContract::COUNTRY_CODE_REGEX)
                  required(:city).filled(:string, max_size?: 255)
                  required(:postcode).filled(:string, max_size?: 255)
                  required(:streetName).filled(:string, max_size?: 255)
                  required(:streetNumber).filled(:string, max_size?: 255)
                end
              end
            end
          end
        end
      end
    end
  end
end

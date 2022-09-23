module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Address
            class << self
              def schema
                Dry::Schema.Params do
                  required(:country).filled(:string, format?: Create::COUNTRY_REGEXP)
                  required(:city).filled(:string, max_size?: 50)
                  required(:postcode).filled(:string, max_size?: 50)
                  required(:streetName).filled(:string, max_size?: 50)
                  required(:streetNumber).filled(:string, max_size?: 50)
                end
              end
            end
          end
        end
      end
    end
  end
end

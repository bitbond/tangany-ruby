module Tangany
  module Customers
    module Contracts
      module Customers
        module UpdateSchemas
          module Address
            class << self
              def schema
                Dry::Schema.Params do
                  optional(:country).filled(:string, format?: Update::COUNTRY_REGEXP)
                  optional(:city).filled(:string, max_size?: 50)
                  optional(:postcode).filled(:string, max_size?: 50)
                  optional(:streetName).filled(:string, max_size?: 50)
                  optional(:streetNumber).filled(:string, max_size?: 50)
                end
              end
            end
          end
        end
      end
    end
  end
end

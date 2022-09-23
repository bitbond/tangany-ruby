require_relative "address"
require_relative "pep"

module Tangany
  module Customers
    module Contracts
      module Customers
        module UpdateSchemas
          module Person
            class << self
              def schema
                Dry::Schema.Params do
                  optional(:pep).hash(Pep.schema)
                  optional(:lastName).filled(:string, max_size?: 50)
                  optional(:email).filled(:string, max_size?: 255)
                  optional(:address).hash(Address.schema)
                end
              end
            end
          end
        end
      end
    end
  end
end

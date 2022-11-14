require_relative "create_schemas/customer"

module Tangany
  module Customers
    module Contracts
      module Customers
        class Create < ApplicationContract
          schema(CreateSchemas::Customer.schema) { config.validate_keys = true }

          rule(:contracts) do
            key.failure("must contain at least one contract") if value.size == 0
          end
        end
      end
    end
  end
end

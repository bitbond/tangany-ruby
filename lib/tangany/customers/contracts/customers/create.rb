require_relative "create_schemas/customer"

module Tangany
  module Customers
    module Contracts
      module Customers
        class Create < ApplicationContract
          schema(CreateSchemas::Customer.schema) { config.validate_keys = true }
        end
      end
    end
  end
end

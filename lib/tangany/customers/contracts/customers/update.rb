require_relative "create"
require_relative "update_schemas/customer"

module Tangany
  module Customers
    module Contracts
      module Customers
        class Update < Create
          schema(UpdateSchemas::Customer.schema) { config.validate_keys = true }
        end
      end
    end
  end
end

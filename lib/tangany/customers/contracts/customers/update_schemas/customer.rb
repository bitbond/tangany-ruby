require_relative "../create_schemas/customer"

module Tangany
  module Customers
    module Contracts
      module Customers
        module UpdateSchemas
          module Customer
            include CreateSchemas::Customer
          end
        end
      end
    end
  end
end

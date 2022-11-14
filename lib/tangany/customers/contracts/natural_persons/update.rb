require_relative "create"
require_relative "update_schemas/natural_person"

module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        class Update < Create
          schema(UpdateSchemas::NaturalPerson.schema) { config.validate_keys = true }
        end
      end
    end
  end
end

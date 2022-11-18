require_relative "../create_schemas/natural_person"

module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        module UpdateSchemas
          module NaturalPerson
            include CreateSchemas::NaturalPerson
          end
        end
      end
    end
  end
end

require_relative "contract"

module Tangany
  module Customers
    module Contracts
      module Customers
        module CreateSchemas
          module Customer
            module ClassMethods
              def schema
                Dry::Schema.Params do
                  required(:id).filled(:string)
                  required(:owner).hash do
                    required(:entityId).filled(:string)
                  end
                  required(:authorized).hash do
                    required(:entityId).filled(:string)
                  end
                  required(:contracts).array(CreateSchemas::Contract.schema)
                end
              end
            end

            extend ClassMethods

            def self.included(base)
              base.extend(ClassMethods)
            end
          end
        end
      end
    end
  end
end

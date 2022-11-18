module Tangany
  module Customers
    module Contracts
      module NaturalPersons
        class List < ApplicationContract
          schema do
            config.validate_keys = true

            optional(:pageToken).maybe(:string)
            optional(:limit).filled(:integer, gteq?: 1, lteq?: 100)
            optional(:sort).filled(:string, included_in?: ALLOWED_SORTS)
          end
        end
      end
    end
  end
end

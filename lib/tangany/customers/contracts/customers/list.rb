module Tangany
  module Customers
    module Contracts
      module Customers
        class List < ApplicationContract
          schema do
            config.validate_keys = true

            optional(:limit).filled(:integer, gteq?: 1, lteq?: 100)
            optional(:sort).filled(:string, included_in?: ALLOWED_SORTS)
            optional(:pageToken).maybe(:string)
          end
        end
      end
    end
  end
end

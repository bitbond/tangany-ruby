module Tangany
  module Customers
    module Contracts
      module WalletLinks
        class List < ApplicationContract
          schema do
            config.validate_keys = true

            optional(:limit).filled(:integer, gt?: 0, lteq?: 500)
            optional(:sort).filled(:string, included_in?: ALLOWED_SORTS)
            optional(:start).filled(:integer, gt?: 0)
          end
        end
      end
    end
  end
end

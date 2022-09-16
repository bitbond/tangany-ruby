module Tangany
  module Customers
    module WalletLinks
      class ListContract < Contract
        ALLOWED_ORDERS = ["created", "security", "updated", "wallet"].freeze

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

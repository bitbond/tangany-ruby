module Tangany
  module Customers
    module Contracts
      module WalletLinks
        class Create < ApplicationContract
          ALLOWED_TYPES = ["waas"].freeze # TODO: add "mpc" support

          schema do
            config.validate_keys = true

            required(:id).filled(:string)
            required(:type).filled(:string, included_in?: ALLOWED_TYPES)
            required(:vaultUrl).filled(:string, format?: URI::DEFAULT_PARSER.make_regexp)
            required(:vaultWalletId).filled(:string)
            required(:assignment).hash do
              required(:customerId).filled(:string)
            end
          end
        end
      end
    end
  end
end

module Tangany
  module Customers
    module Contracts
      module WalletLinks
        class Create < ApplicationContract
          ALLOWED_TYPES = ["waas"].freeze

          schema do
            config.validate_keys = true

            required(:id).filled(:string, max_size?: 40)
            optional(:address).filled(:string, format?: ApplicationContract::ETHEREUM_ADDRESS_REGEX)
            optional(:wallet).filled(:string)
            required(:assetId).filled(:string, included_in?: Tangany::Customers::WalletLink::ALLOWED_CHAIN_IDS)
            optional(:assignment).hash do
              required(:customerId).filled(:string)
            end
          end

          rule do
            key.failure("one ne of address or wallet must be present") if !values[:address] && !values[:wallet]
            key.failure("only one of address or wallet must be present") if values[:address] && values[:wallet]
          end
        end
      end
    end
  end
end

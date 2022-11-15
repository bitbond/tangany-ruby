module Tangany
  module Customers
    module Contracts
      module WalletLinks
        class Create < ApplicationContract
          ALLOWED_TYPES = ["waas"].freeze

          schema do
            config.validate_keys = true

            required(:id).filled(:string, max_size?: 40)
            required(:address).filled(:string, format?: ApplicationContract::ETHEREUM_ADDRESS_REGEX)
            required(:assetId).filled(:string, included_in?: Tangany::Customers::WalletLink::ALLOWED_ASSET_IDS)
            optional(:assignment).hash do
              required(:customerId).filled(:string)
            end
          end
        end
      end
    end
  end
end

module Tangany
  module Customers
    class WalletLink < Object
      ALLOWED_ASSET_IDS = Tangany.networks.keys.freeze

      attribute :id, Types::String
      attribute :address, Types::String
      attribute :assetId, Types::String
      attribute? :assignment do
        attribute :customerId, Types::String
      end
    end
  end
end

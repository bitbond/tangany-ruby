module Tangany
  module Customers
    class WalletLink < Object
      ALLOWED_CHAIN_IDS = Tangany.chains.map { |chain| chain["asset_id"] }.freeze

      attribute :id, Types::String
      attribute :address, Types::String
      attribute :assetId, Types::String
      attribute? :assignment do
        attribute :customerId, Types::String
      end
    end
  end
end

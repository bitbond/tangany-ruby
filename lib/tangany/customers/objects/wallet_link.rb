module Tangany
  module Customers
    class WalletLink < Object
      ALLOWED_ASSET_IDS = %w[
        AAVE
        ADA
        ALGO
        BCH
        BNB
        BTC
        CHZ
        CRV
        DOGE
        DOT
        ENJ
        EOS
        ETC
        ETH
        KSM
        LINK
        LTC
        LUNA
        MANA
        MATIC
        SOL
        UNI
        XLM
        XRP
        XTZ
        YFI
      ].freeze

      attribute :id, Types::String
      attribute :address, Types::String
      attribute :assetId, Types::String
      attribute? :assignment do
        attribute :customerId, Types::String
      end
    end
  end
end

# frozen_string_literal: true

module Tangany
  module Customers
    module WalletLinks
      class CreateContract < Contract
        ALLOWED_TYPES = ["mpc", "waas"].freeze
        ALLOWED_ASSETS = %w[
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
        ].freeze

        attribute :id, Types::String
        attribute :type, Types::String.constrained(included_in: ALLOWED_TYPES)
        attribute? :address, Types::String
        attribute? :assetId, Types::String.constrained(included_in: ALLOWED_ASSETS)
        attribute? :vaultUrl, Types::String.constrained(format: URI::DEFAULT_PARSER.make_regexp)
        attribute? :vaultWalletId, Types::String
        attribute? :assignment do
          attribute :customerId, Types::String
        end
      end
    end
  end
end

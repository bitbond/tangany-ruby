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

        schema do
          config.validate_keys = true

          required(:id).filled(:string)
          required(:type).filled(:string, included_in?: ALLOWED_TYPES)
          optional(:address).filled(:string)
          optional(:assetId).filled(:string, included_in?: ALLOWED_ASSETS)
          optional(:vaultUrl).filled(:string, format?: URI::DEFAULT_PARSER.make_regexp)
          optional(:vaultWalletId).filled(:string)
          required(:assignment).hash do
            required(:customerId).filled(:string)
          end
        end
      end
    end
  end
end

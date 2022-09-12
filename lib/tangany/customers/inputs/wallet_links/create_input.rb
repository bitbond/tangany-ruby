# frozen_string_literal: true

module Tangany
  module Customers
    module WalletLinks
      class CreateInput < Input
        ALLOWED_TYPES = ["mpc", "waas"].freeze

        attribute :id, Types::String
        attribute :type, Types::String.constrained(included_in: ALLOWED_TYPES)
        attribute :vaultUrl, Types::String.constrained(format: URI::DEFAULT_PARSER.make_regexp)
        attribute :vaultWalletId, Types::String
        attribute :assignment do
          attribute :customerId, Types::String
        end
      end
    end
  end
end

module Tangany
  module Customers
    class WalletLink < Object
      attribute :id, Types::String
      attribute? :type, Types::String
      attribute? :vaultUrl, Types::String
      attribute? :vaultWalletId, Types::String
      attribute? :assignment, Types::Hash
    end
  end
end

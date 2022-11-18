module Tangany
  module Custody
    class WalletStatus < Object
      attribute :address, Types::String
      attribute :balance, Types::String
      attribute :currency, Types::String
      attribute :nonce, Types::Integer
    end
  end
end

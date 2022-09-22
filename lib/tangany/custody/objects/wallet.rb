module Tangany
  module Custody
    class Wallet < Object
      attribute :wallet, Types::String
      attribute? :version, Types::String
      attribute? :created, Types::DateTime
      attribute? :updated, Types::DateTime
      attribute? :security, Types::String
      attribute? :public do
        attribute :secp256k1, Types::String
      end
      attribute? :tags, Types::Array

      to_datetime :created, :updated
    end
  end
end

module Tangany
  module Customers
    class Customer < Object
      attribute :id, Types::String
      attribute :owner do
        attribute :entityId, Types::String
      end
      attribute :authorized do
        attribute :entityId, Types::String
      end
      attribute :contracts, Types::Array.of(Contract)
    end
  end
end

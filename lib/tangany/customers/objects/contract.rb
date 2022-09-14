module Tangany
  module Customers
    class Contract < Object
      attribute :isSigned, Types::Bool
      attribute :signedDate, Types::String.optional
      attribute :isCancelled?, Types::Bool
      attribute :cancelledDate?, Types::String.optional
    end
  end
end

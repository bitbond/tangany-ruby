module Tangany
  module Customers
    class Contract < Object
      attribute :isSigned, Types::Bool
      attribute :signedDate, Types::DateTime.optional
      attribute :isCancelled?, Types::Bool
      attribute :cancelledDate?, Types::DateTime.optional

      to_datetime :signedDate, :cancelledDate
    end
  end
end

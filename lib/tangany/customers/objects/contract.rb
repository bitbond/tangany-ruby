# frozen_string_literal: true

module Tangany
  module Customers
    class Contract < Object
      attribute :isSigned, Types::Bool
      attribute :signedDate, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP).optional
      attribute :isCancelled?, Types::Bool
      attribute :cancelledDate?, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP).optional
    end
  end
end

module Tangany
  module Customers
    class Contract < Object
      ALLOWED_TYPES = %w[standard].freeze

      attribute :type, Types::String
      attribute :signedDate, Types::String
      attribute? :cancelledDate, Types::String
    end
  end
end

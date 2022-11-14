module Tangany
  module Customers
    class Contract < Object
      ALLOWED_TYPES = %w[standard].freeze

      attribute :type, Types::String
      attribute :signedDate, Types::Date
      attribute? :cancelledDate, Types::Date

      to_date :signedDate, :cancelledDate
    end
  end
end

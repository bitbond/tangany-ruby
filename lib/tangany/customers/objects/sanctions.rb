module Tangany
  module Customers
    class Sanctions < Object
      attribute :checkDate, Types::DateTime
      attribute :isSanctioned, Types::Bool
      attribute? :source, Types::String.optional
      attribute? :reason, Types::String.optional

      to_datetime :checkDate
    end
  end
end

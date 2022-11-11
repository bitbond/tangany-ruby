module Tangany
  module Customers
    class Sanctions < Object
      attribute :checkDate, Types::DateTime
      attribute :isSanctioned, Types::Bool
      attribute? :source?, Types::String
      attribute? :reason?, Types::String

      to_datetime :checkDate
    end
  end
end

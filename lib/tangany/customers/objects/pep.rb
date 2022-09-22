module Tangany
  module Customers
    class Pep < Object
      attribute :isExposed, Types::Bool
      attribute :checkDate, Types::Date
      attribute :source, Types::String
      attribute :reason?, Types::String.optional
      attribute :isSanctioned?, Types::Bool

      to_date :checkDate
    end
  end
end

module Tangany
  module Customers
    class Pep < Object
      attribute :isExposed, Types::Bool
      attribute :checkDate, Types::Date
      attribute :isSanctioned?, Types::Bool

      censored :source, :reason
      to_date :checkDate
    end
  end
end

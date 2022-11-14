module Tangany
  module Customers
    class Pep < Object
      attribute :checkDate, Types::DateTime
      attribute :isExposed, Types::Bool
      attribute? :source, Types::String
      attribute? :reason, Types::String

      to_datetime :checkDate
    end
  end
end

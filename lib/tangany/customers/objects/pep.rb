module Tangany
  module Customers
    class Pep < Object
      attribute :checkDate, Types::DateTime
      attribute :isExposed, Types::Bool
      attribute? :source, Types::String.optional
      attribute? :reason, Types::String.optional

      to_datetime :checkDate
    end
  end
end

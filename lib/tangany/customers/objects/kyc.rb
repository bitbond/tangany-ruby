module Tangany
  module Customers
    class Kyc < Object
      attribute :id, Types::String
      attribute :date, Types::DateTime
      attribute :method, Types::String
      attribute :document, Document

      to_datetime :date
    end
  end
end

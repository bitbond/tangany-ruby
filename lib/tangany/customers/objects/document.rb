module Tangany
  module Customers
    class Document < Object
      attribute :country, Types::String
      attribute :nationality, Types::String
      attribute :number, Types::String
      attribute :issuedBy, Types::String
      attribute :issueDate, Types::Date
      attribute :validUntil, Types::String
      attribute :type, Types::String

      to_date :issueDate
    end
  end
end

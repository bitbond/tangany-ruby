module Tangany
  module Customers
    class Document < Object
      attribute :country, Types::String
      attribute :nationality, Types::String
      attribute :issueDate, Types::Date
      attribute :type, Types::String

      censored :number, :issuedBy, :validUntil
      to_date :issueDate
    end
  end
end

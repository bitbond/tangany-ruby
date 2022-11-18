module Tangany
  module Customers
    class Document < Object
      ALLOWED_TYPES = %w[id_card passport other].freeze

      attribute :country, Types::String
      attribute :nationality, Types::String
      attribute :number, Types::String
      attribute :issuedBy, Types::String
      attribute :issueDate, Types::Date
      attribute :validUntil, Types::Date
      attribute :type, Types::String

      to_date :issueDate, :validUntil
    end
  end
end

# frozen_string_literal: true

module Tangany
  module Customers
    class Document < Object
      ALLOWED_TYPES = ["id_card", "passport"].freeze

      attribute :country, Types::String.constrained(format: COUNTRY_REGEXP)
      attribute :nationality, Types::String.constrained(format: COUNTRY_REGEXP)
      attribute :number, Types::String.constrained(max_size: 50)
      attribute :issuedBy, Types::String.constrained(max_size: 50)
      attribute :issueDate, Types::String.constrained(format: DATE_REGEXP)
      attribute :validUntil, Types::String.constrained(format: DATE_REGEXP)
      attribute :type, Types::String.constrained(included_in: ALLOWED_TYPES)
    end
  end
end

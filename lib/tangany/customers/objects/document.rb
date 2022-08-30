# frozen_string_literal: true

module Tangany
  module Customers
    class Document < Object
      attribute :country, Types::String
      attribute :nationality, Types::String
      attribute :number, Types::String
      attribute :issuedBy, Types::String
      attribute :issueDate, Types::String
      attribute :validUntil, Types::String
      attribute :type, Types::String
    end
  end
end

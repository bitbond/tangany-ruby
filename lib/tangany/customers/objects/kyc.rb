# frozen_string_literal: true

module Tangany
  module Customers
    class Kyc < Object
      attribute :id, Types::String
      attribute :date, Types::String
      attribute :method, Types::String
      attribute :document, Document
    end
  end
end

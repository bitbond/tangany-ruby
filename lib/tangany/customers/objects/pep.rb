# frozen_string_literal: true

module Tangany
  module Customers
    class Pep < Object
      attribute :isExposed, Types::Bool
      attribute :checkDate, Types::String
      attribute :source, Types::String
      attribute :reason?, Types::String.optional
      attribute :isSanctioned?, Types::Bool
    end
  end
end

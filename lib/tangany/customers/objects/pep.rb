# frozen_string_literal: true

module Tangany
  module Customers
    class Pep < Object
      attribute :isExposed, Types::Bool
      attribute :checkDate, Types::String.constrained(format: DATE_REGEXP)
      attribute :source, Types::String.constrained(max_size: 255).optional
      attribute :reason?, Types::String.optional
      attribute :isSanctioned?, Types::Bool
    end
  end
end

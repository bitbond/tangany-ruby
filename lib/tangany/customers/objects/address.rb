# frozen_string_literal: true

module Tangany
  module Customers
    class Address < Object
      attribute :country, Types::String.constrained(format: COUNTRY_REGEXP)
      attribute :city, Types::String.constrained(max_size: 50)
      attribute :postcode, Types::String.constrained(max_size: 50)
      attribute :streetName, Types::String.constrained(max_size: 50)
      attribute :streetNumber, Types::String.constrained(max_size: 50)
    end
  end
end

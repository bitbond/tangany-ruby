# frozen_string_literal: true

module Tangany
  module Customers
    class Person < Object
      ALLOWED_GENDERS = ["F", "M", "X"].freeze

      attribute :firstName, Types::String.constrained(max_size: 50)
      attribute :lastName, Types::String.constrained(max_size: 50)
      attribute :gender, Types::String.constrained(included_in: ALLOWED_GENDERS)
      attribute :birthDate, Types::String.constrained(format: DATE_REGEXP)
      attribute :birthName, Types::String.constrained(max_size: 50)
      attribute :birthPlace, Types::String.constrained(max_size: 50)
      attribute :birthCountry, Types::String.constrained(format: COUNTRY_REGEXP)
      attribute :nationality, Types::String.constrained(format: COUNTRY_REGEXP)
      attribute :address, Address
      attribute :email, Types::String.constrained(max_size: 255)
      attribute :kyc, Kyc
      attribute :pep, Pep
    end
  end
end

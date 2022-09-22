module Tangany
  module Customers
    class Person < Object
      attribute :firstName, Types::String
      attribute :lastName, Types::String
      attribute :gender, Types::String
      attribute :birthDate, Types::Date
      attribute :birthName, Types::String
      attribute :birthPlace, Types::String
      attribute :birthCountry, Types::String
      attribute :nationality, Types::String
      attribute :address, Address
      attribute :email, Types::String
      attribute :kyc, Kyc
      attribute :pep, Pep

      to_date :birthDate
    end
  end
end

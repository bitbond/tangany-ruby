module Tangany
  module Customers
    class Person < Object
      attribute :lastName, Types::String
      attribute :gender, Types::String
      attribute :birthName, Types::String
      attribute :birthPlace, Types::String
      attribute :birthCountry, Types::String
      attribute :nationality, Types::String
      attribute :address, Address
      attribute :kyc, Kyc
      attribute :pep, Pep

      censored :firstName, :birthDate, :email
    end
  end
end

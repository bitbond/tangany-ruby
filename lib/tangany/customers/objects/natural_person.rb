module Tangany
  module Customers
    class NaturalPerson < Object
      ALLOWED_GENDERS = ["F", "M", "X"].freeze

      attribute :id, Types::String
      attribute? :title, Types::String.optional
      attribute :firstName, Types::String
      attribute :lastName, Types::String
      attribute? :gender, Types::String.optional
      attribute :birthDate, Types::String
      attribute :birthPlace, Types::String
      attribute :birthCountry, Types::String
      attribute? :birthName, Types::String.optional
      attribute? :nationality, Types::String.optional
      attribute? :address, Address
      attribute? :email, Types::String.optional
      attribute? :kyc, Kyc
      attribute? :pep, Pep
      attribute? :sanctions, Sanctions
    end
  end
end

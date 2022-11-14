require_relative "address"
require_relative "kyc"
require_relative "pep"
require_relative "sanctions"

module Tangany
  module Customers
    class NaturalPerson < Object
      ALLOWED_GENDERS = %w[F M X].freeze

      attribute :id, Types::String
      attribute? :title, Types::String
      attribute :firstName, Types::String
      attribute :lastName, Types::String
      attribute? :gender, Types::String
      attribute :birthDate, Types::Date
      attribute :birthPlace, Types::String
      attribute :birthCountry, Types::String
      attribute? :birthName, Types::String
      attribute? :nationality, Types::String
      attribute? :address, Address
      attribute? :email, Types::String
      attribute? :kyc, Kyc
      attribute? :pep, Pep
      attribute? :sanctions, Sanctions
    end
  end
end

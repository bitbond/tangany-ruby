require_relative "address"
require_relative "kyc"
require_relative "pep"
require_relative "sanctions"

module Tangany
  module Customers
    class NaturalPerson < Object
      ALLOWED_GENDERS = %w[F M X].freeze

      attribute :id, Types::String
      attribute? :title, Types::String.optional
      attribute :firstName, Types::String
      attribute :lastName, Types::String
      attribute? :gender, Types::String.optional
      attribute :birthDate, Types::Date
      attribute :birthPlace, Types::String
      attribute :birthCountry, Types::String
      attribute? :birthName, Types::String.optional
      attribute? :nationality, Types::String.optional
      attribute? :address, Address
      attribute? :email, Types::String.optional
      attribute? :kyc, Kyc
      attribute? :pep, Pep
      attribute? :sanctions, Sanctions

      to_date :birthDate
    end
  end
end

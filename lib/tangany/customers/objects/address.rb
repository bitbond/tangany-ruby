module Tangany
  module Customers
    class Address < Object
      attribute :country, Types::String
      attribute :city, Types::String
      attribute :postcode, Types::String
      attribute :streetName, Types::String
      attribute :streetNumber, Types::String
    end
  end
end

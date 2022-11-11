module Tangany
  module Customers
    class Customer < Object
      attribute :id, Types::String
      attribute? :naturalPerson, NaturalPerson
      attribute? :contract, Contract
      attribute? :_links, Types::Hash
    end
  end
end
